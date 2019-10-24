//
//  WXHCodeViewDefaultItem.m
//  xh_textfield
//
//  Created by 路 on 2019/10/24.
//  Copyright © 2019年 路. All rights reserved.
//

#import "WXHCodeViewDefaultItem.h"

@interface WXHCodeViewDefaultItem ()

@property (strong ,nonatomic) UIView *line;
@end

@implementation WXHCodeViewDefaultItem

- (id)init; {
    self = [super init];
    if (self) {
        
        _lineNormalColor = [UIColor grayColor];
        _lineActivatedColor = [UIColor redColor];
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:20];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        _line = [[UIView alloc] init];
        [self addSubview:_line];
        
    } return self;
}

- (void)layoutSubviews; {
    [super layoutSubviews];
    _label.frame = self.bounds;
    _line.frame = CGRectMake(0, self.frame.size.height - 1.f, self.frame.size.width, 1.f);
}

- (void)setText:(NSString *)text; {
    [super setText:text];
    _label.text = text;
}

- (void)setActivated:(BOOL)activated; {
    [super setActivated:activated];
    if (activated) {
        _line.backgroundColor = _lineActivatedColor;
    } else {
        _line.backgroundColor = _lineNormalColor;
    }
}

@end
