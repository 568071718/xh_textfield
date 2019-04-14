//
//  WXHTextBox.m
//  xh_textfield
//
//  Created by 路 on 2019/4/12.
//  Copyright © 2019年 路. All rights reserved.
//

#import "WXHTextBox.h"

@implementation WXHTextBox {
    NSTimer *_timer;
    UIView *_twinkle_line;
}

- (id)init {
    self = [super init];
    if (self) {
        
        _normalColor = [UIColor grayColor];
        _activeColor = [UIColor orangeColor];
        
        self.layer.borderWidth = 2.f;
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        
        _twinkle_line = [[UIView alloc] init];
        _twinkle_line.backgroundColor = _activeColor;
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
    if (_active) {
        _twinkle_line.hidden = !_twinkle_line.hidden;
    }
}

- (void)setActive:(BOOL)active {
    _active = active;
    if (_active) {
        self.layer.borderColor = _activeColor.CGColor;
        _label.textColor = _activeColor;
        _timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(update:) userInfo:nil repeats:YES];
        [_timer fire];
    } else {
        self.layer.borderColor = _normalColor.CGColor;
        _label.textColor = _normalColor;
        [self destroy];
        _twinkle_line.hidden = YES;
    }
}

- (void)destroy; {
    [_timer invalidate];
    _timer = nil;
}

@end
