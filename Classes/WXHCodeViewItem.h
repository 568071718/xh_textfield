//
//  WXHCodeViewItem.h
//  xh_textfield
//
//  Created by 路 on 2019/10/24.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXHCodeViewItem <NSObject>
- (id)init;
@property (assign ,nonatomic) BOOL activated;
@property (strong ,nonatomic) NSString *text;
@optional
- (void)destroy;
@end


@interface WXHCodeViewItem : UIView <WXHCodeViewItem>

- (id)init;
@property (assign ,nonatomic) BOOL activated;
@property (strong ,nonatomic) NSString *text;
- (void)destroy;
@end
