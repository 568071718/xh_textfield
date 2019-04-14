//
//  ViewController.m
//  xh_textfield
//
//  Created by 路 on 2019/4/12.
//  Copyright © 2019年 路. All rights reserved.
//

#import "ViewController.h"
#import "WXHTextBoxField.h"

@interface ViewController () <WXHTextBoxFieldDelegate>

@property (weak ,nonatomic) WXHTextBoxField *testView;
@property (strong ,nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WXHTextBoxField *test = [[WXHTextBoxField alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 44.f)];
    test.numberOfItem = 6;
    test.insets = UIEdgeInsetsMake(0, 10, 0, 10.f);
    test.delegate = self;
    [self.view addSubview:test];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(test.frame) + 44.f, self.view.frame.size.width, 44.f)];
    _label.font = [UIFont systemFontOfSize:15];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    _testView = test;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_testView resignFirstResponder];
}

#pragma mark -
- (void)textField:(WXHTextBoxField *)textField textDidChange:(NSString *)text; {
    
}

- (void)textField:(WXHTextBoxField *)textField didFinish:(NSString *)text; {
    [textField resignFirstResponder];
    _label.text = [NSString stringWithFormat:@"输入完成,当前输入: %@" ,textField.text];
}

@end
