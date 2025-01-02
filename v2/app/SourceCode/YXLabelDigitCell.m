
#import "YXLabelDigitCell.h"

@implementation YXLabelDigitCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews; {
    [super layoutSubviews];
    _label.frame = self.bounds;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    _label.text = text;
}

@end
