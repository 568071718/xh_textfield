//
//  ViewController.m
//  app
//
//  Created by ooc on 2023/8/23.
//

#import "ViewController.h"
#import "YXDigitTextView.h"

@interface ViewController () <YXDigitTextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YXDigitTextView *view = [YXDigitTextView digitTextViewWithNumberOfDigits:6];
    view.frame = CGRectMake(0, 200, self.view.frame.size.width, 100);
    view.delegate = self;
    view.spacing = 10.0;
    view.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [self.view addSubview:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
}

#pragma mark -
- (void)digitTextViewShouldReturn:(YXDigitTextView *)digitTextView {
    [digitTextView resignFirstResponder];
}

- (void)digitTextView:(YXDigitTextView *)digitTextView didCompleteInputWithDigits:(NSString *)digits {
    [digitTextView resignFirstResponder];
    NSLog(@"digits: %@" ,digits);
}

- (void)digitTextView:(YXDigitTextView *)digitTextView configureCell:(YXDigitCell *)cell atIndex:(NSUInteger)index activated:(BOOL)activated {
    if ([cell isKindOfClass:[YXLabelDigitCell class]]) {
        cell.layer.cornerRadius = 10.0;
        cell.layer.masksToBounds = YES;
        if (activated) {
            cell.backgroundColor = [UIColor greenColor];
        } else {
            cell.backgroundColor = [UIColor brownColor];
        }
    }
}

@end
