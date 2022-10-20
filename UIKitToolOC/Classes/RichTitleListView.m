//
//  RichTitleListView.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import "RichTitleListView.h"

#import "RichListView.h"
#import "AttrModel.h"

#import <Masonry/Masonry.h>
@interface RichTitleListView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) RichListView *richListView;
@end

@implementation RichTitleListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.richListView];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(14);
            make.left.equalTo(self).offset(19);
        }];
        [self.richListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
            make.left.equalTo(self).offset(14);
            make.right.equalTo(self).offset(-14);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setModel:(NSArray<AttrModel *> *)model{
    _model = model;
    self.richListView.model = _model;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightRegular)];
    }
    
    return _titleLabel;
}

- (RichListView *)richListView{
    if (!_richListView) {
        _richListView = [[RichListView alloc] init];
        _richListView.backgroundColor = [UIColor whiteColor];
        _richListView.layer.cornerRadius = 5;
        _richListView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.05].CGColor;
        _richListView.layer.shadowOffset = CGSizeMake(0, 4);
        _richListView.layer.shadowOpacity = 1;
        _richListView.layer.shadowRadius = 8;
    }
    
    return _richListView;
}

@end
