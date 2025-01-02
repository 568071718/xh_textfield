
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXDigitCell : UIView

@property (assign ,nonatomic) BOOL activated;
@property (strong ,nonatomic ,nullable) NSString *text;
- (void)destroy;
@end

NS_ASSUME_NONNULL_END
