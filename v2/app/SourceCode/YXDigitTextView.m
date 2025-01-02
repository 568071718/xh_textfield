
#import "YXDigitTextView.h"

@interface YXDigitTextView () <UIKeyInput>

@property (strong ,nonatomic) NSArray <YXDigitCell *>*cells;
@end

@implementation YXDigitTextView

+ (instancetype)digitTextViewWithNumberOfDigits:(NSUInteger)number {
    return [[YXDigitTextView alloc] initWithNumberOfDigits:number];
}
+ (instancetype)digitTextViewWithNumberOfDigits:(NSUInteger)number cellClass:(Class)aClass {
    return [[YXDigitTextView alloc] initWithNumberOfDigits:number cellClass:aClass];
}

- (instancetype)initWithNumberOfDigits:(NSUInteger)number {
    return [self initWithNumberOfDigits:number cellClass:[YXLabelDigitCell class]];
}

- (instancetype)initWithNumberOfDigits:(NSUInteger)number cellClass:(Class)aClass {
    self = [super init];
    if (self) {
        _spacing = 0.0;
        _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.returnKeyType = UIReturnKeyDone;
        [self createCellsWithCellClass:aClass count:number];
    }
    return self;
}

- (void)dealloc {
    for (int i = 0; i < _cells.count; i ++) {
        YXDigitCell *cell = _cells[i];
        if ([cell respondsToSelector:@selector(destroy)]) {
            [cell destroy];
        }
        [cell removeFromSuperview];
    }
    _cells = nil;
}

#pragma mark -
- (void)createCellsWithCellClass:(Class)aClass count:(NSInteger)count {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i ++) {
        UIView *cell = [[aClass alloc] init];
        [self addSubview:cell];
        [array addObject:cell];
    }
    _cells = [array copy];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_cells.count <= 0) { return; }
    CGFloat y = _edgeInsets.top;
    CGFloat w = (self.frame.size.width - _edgeInsets.left - _edgeInsets.right - (_cells.count - 1) * _spacing) / _cells.count;
    CGFloat h = self.frame.size.height - _edgeInsets.top - _edgeInsets.bottom;
    for (int i = 0; i < _cells.count; i ++) {
        CGFloat x = _edgeInsets.left + (w + _spacing) * i;
        YXDigitCell *cell = _cells[i];
        CGRect frame = CGRectMake(x, y, w, h);
        cell.frame = frame;
    }
    [self updateCellActivated];
}

- (void)updateCellActivated; {
    for (int i = 0; i < _cells.count; i ++) {
        YXDigitCell *cell = _cells[i];
        cell.activated = NO;
        if ([_delegate respondsToSelector:@selector(digitTextView:configureCell:atIndex:activated:)]) {
            [_delegate digitTextView:self configureCell:cell atIndex:i activated:cell.activated];
        }
    }
    if (self.isFirstResponder) {
        for (int i = 0; i < _cells.count; i ++) {
            YXDigitCell *cell = _cells[i];
            if (cell.text.length == 0 || i == _cells.count - 1) {
                cell.activated = YES;
                if ([_delegate respondsToSelector:@selector(digitTextView:configureCell:atIndex:activated:)]) {
                    [_delegate digitTextView:self configureCell:cell atIndex:i activated:cell.activated];
                }
                break;
            }
        }
    }
}

#pragma mark -

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder; {
    BOOL result = [super becomeFirstResponder];
    if (result) {
        [self updateCellActivated];
    }
    return result;
}

- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    if (result) {
        [self updateCellActivated];
    }
    return result;
}

#pragma mark - UIKeyInput
- (BOOL)hasText; {
    return YES;
}

- (void)insertText:(NSString *)text; {
    /// 换行符
    if ([text isEqualToString:@"\n"]) {
        if ([_delegate respondsToSelector:@selector(digitTextViewShouldReturn:)]) {
            [_delegate digitTextViewShouldReturn:self];
        }
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length == 0) {
        return;
    }
    for (int i = 0; i < _cells.count; i ++) {
        YXDigitCell *cell = _cells[i];
        if (cell.text.length == 0) {
            cell.text = text;
            if (i == _cells.count - 1) {
                /// 输入完成
                if ([_delegate respondsToSelector:@selector(digitTextView:didCompleteInputWithDigits:)]) {
                    [_delegate digitTextView:self didCompleteInputWithDigits:self.text];
                }
            }
            break;
        }
    }
    [self updateCellActivated];
}

- (void)deleteBackward; {
    for (NSInteger i = _cells.count - 1; i >= 0; i --) {
        YXDigitCell *cell = _cells[i];
        if (cell.text.length > 0) {
            cell.text = nil;
            break;
        }
    }
    [self updateCellActivated];
}

#pragma mark -
- (NSString *)text {
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:_cells.count];
    for (int i = 0; i < _cells.count; i ++) {
        YXDigitCell *cell = _cells[i];
        NSString *charElement = cell.text;
        if ([charElement isKindOfClass:[NSString class]]) {
            [string appendString:charElement];
        }
    }
    return [string copy];
}

@end
