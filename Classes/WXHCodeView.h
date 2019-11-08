//
//  WXHCodeView.h
//  xh_textfield
//
//  Created by 路 on 2019/10/24.
//  Copyright © 2019年 路. All rights reserved.
//  https://github.com/568071718/xh_textfield

#import <UIKit/UIKit.h>
#import "WXHCodeViewDefaultItem.h"

@class WXHCodeView;
@protocol WXHCodeViewDelegate <NSObject>
@optional
- (void)codeView:(WXHCodeView *)codeView fullText:(NSString *)fullText;
- (void)codeViewShouldReturn:(WXHCodeView *)codeView;
@end

@interface WXHCodeView : UIView

- (id)initWithNumberOfItem:(NSUInteger)number;
- (id)initWithNumberOfItem:(NSUInteger)number itemClass:(Class)aClass;

@property (assign ,nonatomic) CGFloat spacing; // 默认: 10
@property (assign ,nonatomic) UIEdgeInsets edgeInsets; // 默认: UIEdgeInsetsMake(0, 0, 0, 0);

@property (weak ,nonatomic) IBOutlet id <WXHCodeViewDelegate>delegate;

@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UIReturnKeyType returnKeyType;

@property (strong ,readwrite) UIView *inputView;
@property (strong ,readwrite) UIView *inputAccessoryView;

@property (strong ,nonatomic ,readonly) NSArray <UIView <WXHCodeViewItem>*>*items;
- (NSString *)text;
@end
