//
//  WXHTextBoxField.m
//  xh_textfield
//
//  Created by 路 on 2019/4/12.
//  Copyright © 2019年 路. All rights reserved.
//

#import "WXHTextBoxField.h"
#import "WXHTextBox.h"

@interface WXHTextBoxField ()

/// 设置当前正在编辑的位置
@property (assign ,nonatomic) NSInteger editingIndex;
@end

@implementation WXHTextBoxField {
    NSArray <WXHTextBox *>*_items;
}
@synthesize secureTextEntry = _secureTextEntry;

#pragma mark -
- (void)_reloadData {
    _items = nil;
    for (WXHTextBox *subview in self.subviews) {
        if ([subview isKindOfClass:[WXHTextBox class]]) {
            [subview destroy];
            [subview removeFromSuperview];
        }
    }
    
    // 计算 item size
    CGSize itemSize = CGSizeZero;
    itemSize.height = self.frame.size.height - _insets.top - _insets.bottom;
    itemSize.width = itemSize.height;
    
    // 计算间距
    CGFloat spacing = 0;
    if (_numberOfItem > 1) {
        spacing = (self.frame.size.width - _insets.left - _insets.right - itemSize.width * _numberOfItem) / (_numberOfItem - 1);
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:_numberOfItem];
    for (int i = 0; i < _numberOfItem; i ++) {
        WXHTextBox *item = [[WXHTextBox alloc] init];
        item.frame = ({
            CGRect frame = item.frame;
            frame.origin.x = _insets.left + (itemSize.width + spacing) * i;
            frame.origin.y = _insets.top;
            frame.size = itemSize;
            frame;
        });
        item.active = [self isFirstResponder] && (i == _editingIndex);
        [self addSubview:item];
        item.backgroundColor = [UIColor whiteColor];
        [items addObject:item];
    }
    _items = [items copy];
}

- (void)_resetAllItem {
    for (WXHTextBox *object in _items) object.active = NO;
}

#pragma mark - setter
- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    [self _reloadData];
}

- (void)setNumberOfItem:(NSInteger)numberOfItem {
    _numberOfItem = numberOfItem;
    _editingIndex = 0;
    [self _reloadData];
}

- (void)setEditingIndex:(NSInteger)editingIndex {
    _editingIndex = editingIndex;
    if (_editingIndex >= 0 && _editingIndex < _items.count) {
        for (int i = 0; i < _items.count; i ++) {
            _items[i].active = (i == _editingIndex);
        }
    } else {
        [self _resetAllItem];
    }
}

#pragma mark - getter
- (NSString *)text; {
    NSMutableString *string = [[NSMutableString alloc] init];
    for (WXHTextBox *object in _items) {
        NSString *c = object.label.text;
        if (c.length > 0) {
            [string appendString:[c stringByReplacingOccurrencesOfString:@" " withString:@""]];
        }
    }
    return [string copy];
}

#pragma mark - overwrite
- (BOOL)resignFirstResponder {
    [self _resetAllItem];
    return [super resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _reloadData];
}

#pragma mark - key input
- (BOOL)hasText; {
    return YES;
}

- (void)insertText:(NSString *)text; {
    NSInteger editingIndex = -1;
    for (int i = 0; i < _items.count; i ++) {
        WXHTextBox *object = _items[i];
        if (object.active) {
            editingIndex = i; break;
        }
    }
    if (editingIndex == -1) {
        return;
    }
    
    WXHTextBox *editingItem = _items[editingIndex];
    editingItem.label.text = text;
    editingItem.active = NO;
    
    if ([_delegate respondsToSelector:@selector(textField:textDidChange:)]) {
        [_delegate textField:self textDidChange:self.text];
    }
    
    NSInteger nextIndex = editingIndex + 1;
    if (nextIndex < _items.count) {
        self.editingIndex = nextIndex;
    } else {
        if ([_delegate respondsToSelector:@selector(textField:didFinish:)]) {
            [_delegate textField:self didFinish:self.text];
        }
    }
}

- (void)deleteBackward; {
    if (_editingIndex > 0) {
        // 判断如果当前编辑的位置是最后一位并且最后一位已有内容，只做清空内容处理，不做退格处理
        UILabel *label = _items[_editingIndex].label;
        if (label.text.length > 0 && _editingIndex == _items.count - 1) {
            label.text = nil;
        } else {
            self.editingIndex = _editingIndex - 1;
            _items[_editingIndex].label.text = nil;
        }
    }
    if ([_delegate respondsToSelector:@selector(textField:textDidChange:)]) {
        [_delegate textField:self textDidChange:self.text];
    }
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
    self.editingIndex = _editingIndex;
}

- (void)dealloc {
    for (WXHTextBox *object in _items) {
        [object destroy];
    }
}

@end
