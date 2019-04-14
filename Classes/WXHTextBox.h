//
//  WXHTextBox.h
//  xh_textfield
//
//  Created by 路 on 2019/4/12.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXHTextBox : UIView

/// 标记是否是正在编辑状态
@property (assign ,nonatomic) BOOL active;

/// 显示文本
@property (strong ,nonatomic) UILabel *label;

@property (strong ,nonatomic) UIColor *normalColor; // 正常状态主题色
@property (strong ,nonatomic) UIColor *activeColor; // 激活状态主题色
- (void)destroy;
@end

NS_ASSUME_NONNULL_END
