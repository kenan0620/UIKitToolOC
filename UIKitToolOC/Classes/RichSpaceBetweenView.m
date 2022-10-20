//
//  RichSpaceBetweenView.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import "RichSpaceBetweenView.h"

#import <YYText/YYText.h>
#import <Masonry/Masonry.h>

@interface RichSpaceBetweenView ()
/// 标题
@property (nonatomic, strong) YYLabel *titleLabel;
/// 内容
@property (nonatomic, strong) YYLabel *valueLabel;
@end

@implementation RichSpaceBetweenView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.05].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 8;
        [self addSubview:self.titleLabel];
        [self addSubview:self.valueLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(14);
            make.left.equalTo(self).offset(14);
            make.bottom.lessThanOrEqualTo(self).offset(-14);
        }];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self).offset(14);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(14);
            make.right.equalTo(self).offset(-14);
            make.bottom.lessThanOrEqualTo(self).offset(-14);
        }];
        
    }
    
    return self;
}

- (void)setIsHaveEvent:(bool)isHaveEvent{
    _isHaveEvent = isHaveEvent;
    if (_isHaveEvent) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [self addGestureRecognizer:tap];
    }
}
- (void)click{
    if (self.eventBlock) {
        self.eventBlock();
    }
}

- (void)setTitle:(NSMutableAttributedString *)title{
    _title = title;
    self.titleLabel.attributedText = _title;
}

- (void)setValue:(NSMutableAttributedString *)value{
    _value = value;
    self.valueLabel.attributedText = _value;
}

//MARK: -----------------------UILazy-----------------------
- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[YYLabel alloc] init];
    }
    
    return _titleLabel;
}

- (YYLabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[YYLabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _valueLabel;
}

@end
