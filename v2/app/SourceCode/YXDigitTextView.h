//  Copyright © 2019年 路. All rights reserved.

#import <UIKit/UIKit.h>
#import "YXLabelDigitCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YXDigitTextView;
@protocol YXDigitTextViewDelegate <NSObject>

@optional
- (void)digitTextViewShouldReturn:(YXDigitTextView *)digitTextView;
- (void)digitTextView:(YXDigitTextView *)digitTextView didCompleteInputWithDigits:(NSString *)digits;
- (void)digitTextView:(YXDigitTextView *)digitTextView configureCell:(YXDigitCell *)cell atIndex:(NSUInteger)index activated:(BOOL)activated;
@end

@interface YXDigitTextView : UIView

+ (instancetype)digitTextViewWithNumberOfDigits:(NSUInteger)number;
+ (instancetype)digitTextViewWithNumberOfDigits:(NSUInteger)number cellClass:(Class)aClass;

- (instancetype)initWithNumberOfDigits:(NSUInteger)number;
- (instancetype)initWithNumberOfDigits:(NSUInteger)number cellClass:(Class)aClass;

@property (weak ,nonatomic) id <YXDigitTextViewDelegate>delegate;

@property (assign ,nonatomic) CGFloat spacing;
@property (assign ,nonatomic) UIEdgeInsets edgeInsets;

- (NSString *)text;

#pragma mark -
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UIReturnKeyType returnKeyType;
@property (strong ,readwrite) UIView *inputView;
@property (strong ,readwrite) UIView *inputAccessoryView;

#pragma mark -
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
