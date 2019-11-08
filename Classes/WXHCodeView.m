//
//  WXHCodeView.m
//  xh_textfield
//
//  Created by 路 on 2019/10/24.
//  Copyright © 2019年 路. All rights reserved.
//

#import "WXHCodeView.h"

IB_DESIGNABLE @interface WXHCodeView () <UIKeyInput>

@property (assign ,nonatomic) IBInspectable NSUInteger itemCount;
@property (strong ,nonatomic) IBInspectable NSString *itemClass;
@end

@implementation WXHCodeView

- (id)initWithNumberOfItem:(NSUInteger)number; {
    return [self initWithNumberOfItem:number itemClass:[WXHCodeViewDefaultItem class]];
}

- (id)initWithNumberOfItem:(NSUInteger)number itemClass:(Class)aClass; {
    self = [super init];
    if (self) {
        _spacing = 10.f;
        _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.returnKeyType = UIReturnKeyDone;
        [self __setup__number:number item_class:aClass];
    } return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder; {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _spacing = 10.f;
        _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.returnKeyType = UIReturnKeyDone;

        _itemCount = 4;
        _itemClass = @"WXHCodeViewDefaultItem";
    } return self;
}

- (void)awakeFromNib; {
    [super awakeFromNib];
    [self __setup__number:_itemCount item_class:NSClassFromString(_itemClass)];
}

- (void)prepareForInterfaceBuilder; {
    _spacing = 10.f;
    _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    if (_itemCount == 0) _itemCount = 4;
    if (!_itemClass) _itemClass = @"WXHCodeViewDefaultItem";
    [self __setup__number:_itemCount item_class:NSClassFromString(_itemClass)];
    for (int i = 0; i < _items.count; i ++) {
        UIView <WXHCodeViewItem>*item = _items[i];
        if (i < _items.count - 1) {
            item.text = @"8";
        }
    }
}

- (void)__setup__number:(NSInteger)number item_class:(Class)aClass; {
    NSAssert([aClass conformsToProtocol:@protocol(WXHCodeViewItem)], @"自定义 item class 错误");
    if (number > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:number];
        for (int i = 0; i < number; i ++) {
            UIView <WXHCodeViewItem>*item = [[aClass alloc] init];
            [self addSubview:item];
            [array addObject:item];
        }
        _items = [array copy];
    }
}

- (void)dealloc; {
    for (int i = 0; i < _items.count; i ++) {
        UIView <WXHCodeViewItem>*item = _items[i];
        if ([item respondsToSelector:@selector(destroy)]) {
            [item destroy];
        }
        [item removeFromSuperview];
    }
    _items = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat y = _edgeInsets.top;
    CGFloat w = (self.frame.size.width - _edgeInsets.left - _edgeInsets.right - (_items.count - 1) * _spacing) / _items.count;
    CGFloat h = self.frame.size.height - _edgeInsets.top - _edgeInsets.bottom;
    for (int i = 0; i < _items.count; i ++) {
        CGFloat x = _edgeInsets.left + (w + _spacing) * i;
        UIView <WXHCodeViewItem>*item = _items[i];
        CGRect frame = CGRectMake(x, y, w, h);
        item.frame = frame;
    }
    [self updateCurrentActivatedItem];
}

- (BOOL)becomeFirstResponder; {
    BOOL result = [super becomeFirstResponder];
    if (result) {
        [self updateCurrentActivatedItem];
    }
    return result;
}

- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    if (result) {
        [self updateCurrentActivatedItem];
    }
    return result;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}

#pragma mark -
- (void)updateCurrentActivatedItem; {
    for (int i = 0; i < _items.count; i ++) {
        _items[i].activated = NO;
    }
    if (self.isFirstResponder) {
        for (int i = 0; i < _items.count; i ++) {
            UIView <WXHCodeViewItem>*item = _items[i];
            if (item.text.length == 0 || i == _items.count - 1) {
                item.activated = YES;
                break;
            }
        }
    }
}

#pragma mark - key input
- (BOOL)hasText; {
    return YES;
}

- (void)insertText:(NSString *)text; {
    /// 换行符
    if ([text isEqualToString:@"\n"]) {
        if ([_delegate respondsToSelector:@selector(codeViewShouldReturn:)]) {
            [_delegate codeViewShouldReturn:self];
        }
        return;
    }
    
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length == 0) {
        return;
    }
    for (int i = 0; i < _items.count; i ++) {
        UIView <WXHCodeViewItem>*item = _items[i];
        if (item.text.length == 0) {
            item.text = text;
            if (i == _items.count - 1) {
                /// 输入完成
                if ([_delegate respondsToSelector:@selector(codeView:fullText:)]) {
                    [_delegate codeView:self fullText:self.text];
                }
            }
            break;
        }
    }
    [self updateCurrentActivatedItem];
}

- (void)deleteBackward; {
    for (int i = (int)(_items.count - 1); i >= 0; i --) {
        UIView <WXHCodeViewItem>*item = _items[i];
        if (item.text.length > 0) {
            item.text = nil;
            break;
        }
    }
    [self updateCurrentActivatedItem];
}

- (NSString *)text; {
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:_items.count];
    for (int i = 0; i < _items.count; i ++) {
        UIView <WXHCodeViewItem>*item = _items[i];
        if (item.text) {
            [string appendString:item.text];
        }
    }
    return [string copy];
}

@end
