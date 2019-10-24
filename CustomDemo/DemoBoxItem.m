//
//  DemoBoxItem.m
//  xh_textfield
//
//  Created by 路 on 2019/10/24.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoBoxItem.h"

@implementation DemoBoxItem {
    NSTimer *_timer;
    UIView *_twinkle_line;
}

- (id)init {
    self = [super init];
    if (self) {
        
        self.layer.borderWidth = 2.f;
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        
        _twinkle_line = [[UIView alloc] init];
        _twinkle_line.backgroundColor = [UIColor orangeColor];
        _twinkle_line.hidden = YES;
        [self addSubview:_twinkle_line];
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    } return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _twinkle_line.bounds = CGRectMake(0, 0, 2.f, 15.f);
    _twinkle_line.center = CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
    _label.frame = self.bounds;
}

- (void)update:(NSTimer *)sender {
    if (self.activated) {
        _twinkle_line.hidden = !_twinkle_line.hidden;
    }
}

- (void)setActivated:(BOOL)activated {
    [super setActivated:activated];
    if (activated) {
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        _label.textColor = [UIColor orangeColor];
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(update:) userInfo:nil repeats:YES];
            [_timer fire];
        }
    } else {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        _label.textColor = [UIColor grayColor];
        [self destroy];
        _twinkle_line.hidden = YES;
    }
}

- (void)setText:(NSString *)text; {
    [super setText:text];
    _label.text = text;
}

- (void)destroy; {
    [_timer invalidate];
    _timer = nil;
}

@end
