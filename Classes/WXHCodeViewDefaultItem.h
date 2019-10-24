//
//  WXHCodeViewDefaultItem.h
//  xh_textfield
//
//  Created by 路 on 2019/10/24.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXHCodeViewItem.h"

@interface WXHCodeViewDefaultItem : WXHCodeViewItem

@property (strong ,nonatomic ,readonly) UILabel *label;
@property (strong ,nonatomic) UIColor *lineNormalColor;
@property (strong ,nonatomic) UIColor *lineActivatedColor;
@end
