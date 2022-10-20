//
//  RichListTVCell.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import "RichListTVCell.h"

#import "AttrModel.h"
#import <Masonry/Masonry.h>

@interface RichListTVCell ()
@property (nonatomic, strong) UILabel *titleRichLabel;
@property (nonatomic, strong) UILabel *valueRichLabel;
@property (nonatomic, strong) UIView *dividerView;
@end

@implementation RichListTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleRichLabel];
        [self.contentView addSubview:self.valueRichLabel];
        [self.contentView addSubview:self.dividerView];
        [self.titleRichLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self.contentView).offset(14);
            make.left.equalTo(self.contentView).offset(14);
            make.centerY.equalTo(self.contentView);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-14);
        }];
        [self.valueRichLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(self.contentView).offset(14).priorityHigh();
            make.left.greaterThanOrEqualTo(self.titleRichLabel.mas_right).offset(14);
            make.right.equalTo(self.contentView).offset(-14);
            make.centerY.equalTo(self.contentView);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-14).priorityHigh();
        }];
        [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(14);
            make.bottom.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
    }
    
    return self;
}


- (void)setModel:(AttrModel *)model{
    _model = model;
    self.titleRichLabel.attributedText = _model.key;
    self.valueRichLabel.attributedText = _model.value;
    self.dividerView.hidden = !_model.isShowLine;
    if (_model.isUpdateLineSpace) {
        [self.dividerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(_model.lineSpace);
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleRichLabel{
    if (!_titleRichLabel) {
        _titleRichLabel = [[UILabel alloc] init];
    }
    
    return _titleRichLabel;
}

- (UILabel *)valueRichLabel{
    if (!_valueRichLabel) {
        _valueRichLabel = [[UILabel alloc] init];
        _valueRichLabel.textAlignment = NSTextAlignmentRight;
        _valueRichLabel.numberOfLines = 0;
    }
    
    return _valueRichLabel;
}

- (UIView *)dividerView{
    if (!_dividerView) {
        _dividerView = [[UIView alloc]init];
        _dividerView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05];
    }
    
    return _dividerView;
}

@end
