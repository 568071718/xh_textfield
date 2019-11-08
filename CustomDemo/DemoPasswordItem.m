//
//  DemoPasswordItem.m
//  xh_textfield
//
//  Created by 路 on 2019/11/8.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoPasswordItem.h"

@implementation DemoPasswordItem {
    UIView *_blackPointView;
}

- (id)init; {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _blackPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _blackPointView.backgroundColor = [UIColor blackColor];
        _blackPointView.layer.cornerRadius = _blackPointView.frame.size.height * .5;
        _blackPointView.layer.masksToBounds = YES;
        _blackPointView.hidden = YES;
        [self addSubview:_blackPointView];
    } return self;
}

- (void)layoutSubviews; {
    [super layoutSubviews];
    _blackPointView.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
}

- (void)setText:(NSString *)text; {
    [super setText:text];
    _blackPointView.hidden = (text == nil);
}

@end
