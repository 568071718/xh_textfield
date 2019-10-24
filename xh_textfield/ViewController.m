//
//  ViewController.m
//  xh_textfield
//
//  Created by 路 on 2019/4/12.
//  Copyright © 2019年 路. All rights reserved.
//

#import "ViewController.h"
#import "WXHCodeView.h"
#import "DemoBoxItem.h"

@interface ViewController () <WXHCodeViewDelegate>

@property (strong ,nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WXHCodeView *customCodeView = [[WXHCodeView alloc] initWithNumberOfItem:6 itemClass:[DemoBoxItem class]];
    customCodeView.frame = CGRectMake(0, 111, self.view.frame.size.width, 44.f);
    customCodeView.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10.f);
    customCodeView.delegate = self;
    for (DemoBoxItem *item in customCodeView.items) {
        item.label.font = [UIFont boldSystemFontOfSize:22];
    }
    [self.view addSubview:customCodeView];
    
    WXHCodeView *codeView = [[WXHCodeView alloc] initWithNumberOfItem:6];
    codeView.frame = CGRectMake(0, CGRectGetMaxY(customCodeView.frame) + 44.f, self.view.frame.size.width, 44.f);
    codeView.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10.f);
    codeView.delegate = self;
    for (WXHCodeViewDefaultItem *item in codeView.items) {
        item.label.font = [UIFont boldSystemFontOfSize:22];
    }
    [self.view addSubview:codeView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(codeView.frame) + 44.f, self.view.frame.size.width, 44.f)];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -

- (void)codeView:(WXHCodeView *)codeView fullText:(NSString *)fullText {
    [codeView resignFirstResponder];
    _label.text = [NSString stringWithFormat:@"输入完成,当前输入: %@" ,fullText];
}

@end
