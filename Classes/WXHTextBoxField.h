//
//  WXHTextBoxField.h
//  xh_textfield
//
//  Created by 路 on 2019/4/12.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WXHTextBoxField;
@protocol WXHTextBoxFieldDelegate <NSObject>
@optional
- (void)textField:(WXHTextBoxField *)textField textDidChange:(NSString *)text;
- (void)textField:(WXHTextBoxField *)textField didFinish:(NSString *)text;
@end

@interface WXHTextBoxField : UIControl <UIKeyInput>

@property (weak ,nonatomic) id <WXHTextBoxFieldDelegate>delegate;
@property (assign ,nonatomic) UIEdgeInsets insets; /// 设置文本框边距
@property (assign ,nonatomic) NSInteger numberOfItem; /// 设置文本框数量
- (NSString *)text; /// 获取文本内容
@end

NS_ASSUME_NONNULL_END
