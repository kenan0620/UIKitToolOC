//
//  TimePicker.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/7/25.
//

#import "TimePicker.h"

#import <CategoryToolOC/NSDate+Category.h>
#import <CategoryToolOC/UIColor+Category.h>
#import <CategoryToolOC/UIFont+Category.h>

#import <Masonry/Masonry.h>

@interface TimePicker ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIView *bgView;
/// 取消
@property (nonatomic, strong) UIButton *cancelBtn;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 确认
@property (nonatomic, strong) UIButton *confirmBtn;
/// 分割线
@property (nonatomic, strong) UIView *dividerView;
/// 时间选择器
@property (nonatomic, strong) UIPickerView *timePicker;

@property (nonatomic, assign) NSInteger selectYear;
@property (nonatomic, assign) NSInteger selectMonth;
@property (nonatomic, assign) NSInteger selectDay;
@property (nonatomic, assign) NSInteger selectHour;
@property (nonatomic, assign) NSInteger selectMinute;
@property (nonatomic, assign) NSInteger selectSecond;

@end

@implementation TimePicker

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configData];
        [self configUI];
        [self configSelectRow:self.defaultDate YearRow:501 IsScroll:true];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(14, [UIScreen mainScreen].bounds.size.height / 2 - 35 - 44, [UIScreen mainScreen].bounds.size.width - 28, 70) cornerRadius:5];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        layer.fillColor = UIColor.clearColor.CGColor; // 空心
        layer.strokeColor = [UIColor colorHex:@"#0066FF"].CGColor;
        layer.lineWidth = 2;
        [self.bgView.layer addSublayer:layer];
        
        for (UIView *view in self.timePicker.subviews) {
            NSLog(@"自视图是 %@",NSStringFromClass([view class]));
            if ([NSStringFromClass([view class]) isEqualToString:@"_UIPickerHighlightView"]) {
                view.hidden = true;
            }
        }
    }
    
    return self;
}

#pragma mark - Event
- (void)cancelBtnClick{
    if ([self.delegate respondsToSelector:@selector(cancelActionWithTarget:)]) {
        [self.delegate cancelActionWithTarget:self.target];
    }
}

- (void)confirmBtnClick{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:self.selectYear];
    [components setMonth:self.selectMonth];
    [components setDay:self.selectDay];
    [components setHour:self.selectHour];
    [components setMinute:self.selectMinute];
    [components setSecond:self.selectSecond];
    
    if ([self.delegate respondsToSelector:@selector(confirmActionWithDate:withTarget:)]) {
        [self.delegate confirmActionWithDate:[calendar dateFromComponents:components] withTarget:self.target];
    }
}

#pragma mark - Setter
-(void)setMode:(TimePickerMode)mode{
    _mode = mode;
}

- (void)setIsShowLine:(bool)isShowLine{
    _isShowLine = isShowLine;
    self.dividerView.hidden = !_isShowLine;
}

- (void)setTarget:(NSInteger)target{
    _target = target;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.titleLabel.font = _titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setCancelText:(NSString *)cancelText{
    _cancelText = cancelText;
    [self.cancelBtn setTitle:_cancelText forState:(UIControlStateNormal)];
}

- (void)setCancelFont:(UIFont *)cancelFont{
    _cancelFont = cancelFont;
    self.cancelBtn.titleLabel.font = _cancelFont;
}

- (void)setCancelColor:(UIColor *)cancelColor{
    _cancelColor = cancelColor;
    [self.cancelBtn setTitleColor:_cancelColor forState:(UIControlStateNormal)];
    [self.cancelBtn setTitleColor:_cancelColor forState:(UIControlStateSelected)];
    [self.cancelBtn setTitleColor:_cancelColor forState:(UIControlStateHighlighted)];
}

- (void)setConfirmText:(NSString *)confirmText{
    _confirmText = confirmText;
    [self.confirmBtn setTitle:_confirmText forState:(UIControlStateNormal)];
}

- (void)setConfirmFont:(UIFont *)confirmFont{
    _confirmFont = confirmFont;
    self.confirmBtn.titleLabel.font = _confirmFont;
}


- (void)setConfirmColor:(UIColor *)confirmColor{
    _confirmColor = confirmColor;
    [self.confirmBtn setTitleColor:_confirmColor forState:(UIControlStateNormal)];
    [self.confirmBtn setTitleColor:_confirmColor forState:(UIControlStateSelected)];
    [self.confirmBtn setTitleColor:_confirmColor forState:(UIControlStateHighlighted)];
}

- (void)setDefaultDate:(NSDate *)defaultDate{
    _defaultDate = defaultDate;
    [self configSelectRow:_defaultDate YearRow:501 IsScroll:true];
}

- (void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
}

- (void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
}

- (void)setPickerFont:(UIFont *)pickerFont{
    _pickerFont = pickerFont;
}

- (void)setPickerColor:(UIColor *)pickerColor{
    _pickerColor = pickerColor;
}

#pragma mark - config
- (void)configData{
    self.defaultDate = [NSDate date];
    self.pickerFont = [UIFont systemMediumFont:16];
    self.pickerColor = [UIColor blackColor];
    self.mode = TimeModle_YMDHMS;
}

- (void)configSelectRow:(NSDate *)date YearRow:(NSInteger)yearRow IsScroll:(BOOL)isScroll{
    self.selectYear = date.year;
    self.selectMonth = date.month;
    self.selectDay = date.day;
    self.selectHour = date.hour;
    self.selectMinute = date.minute;
    self.selectSecond = date.second;
    
    switch (self.mode) {
        case TimeModle_Y:
            [self.timePicker selectRow:yearRow inComponent:0 animated:true];
            break;
        case TimeModle_YM:
            [self.timePicker selectRow:yearRow inComponent:0 animated:true];
            [self.timePicker selectRow:(12 * 500 + date.month - 1) inComponent:1 animated:true];
            break;
        case TimeModle_YMD:
            [self.timePicker selectRow:yearRow inComponent:0 animated:true];
            [self.timePicker selectRow:(12 * 500 + date.month - 1) inComponent:1 animated:true];
            [self.timePicker selectRow:(31 * 500 + date.day - 1)  inComponent:2 animated:true];
            break;
        case  TimeModle_YMDH:
            [self.timePicker selectRow:yearRow inComponent:0 animated:true];
            [self.timePicker selectRow:(12 * 500 + date.month - 1) inComponent:1 animated:true];
            [self.timePicker selectRow:(31 * 500 + date.day - 1)  inComponent:2 animated:true];
            if (isScroll) {
                [self.timePicker selectRow:(24 * 500 + date.hour)  inComponent:3 animated:true];
            }
            break;
        case TimeModle_YMDHM:
            [self.timePicker selectRow:yearRow inComponent:0 animated:true];
            [self.timePicker selectRow:(12 * 500 + date.month - 1) inComponent:1 animated:true];
            [self.timePicker selectRow:(31 * 500 + date.day - 1)  inComponent:2 animated:true];
            if (isScroll) {
                [self.timePicker selectRow:(24 * 500 + date.hour)  inComponent:3 animated:true];
                [self.timePicker selectRow:(60 * 500 + date.minute)  inComponent:4 animated:true];
            }
            break;
        case TimeModle_YMDHMS:
            [self.timePicker selectRow:yearRow inComponent:0 animated:true];
            [self.timePicker selectRow:(12 * 500 + date.month - 1) inComponent:1 animated:true];
            [self.timePicker selectRow:(31 * 500 + date.day - 1)  inComponent:2 animated:true];
            if (isScroll) {
                [self.timePicker selectRow:(24 * 500 + date.hour)  inComponent:3 animated:true];
                [self.timePicker selectRow:(60 * 500 + date.minute)  inComponent:4 animated:true];
                [self.timePicker selectRow:(60 * 500 + date.second)  inComponent:5 animated:true];
            }
            break;
    }
}

- (void)configUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.cancelBtn];
    [self.bgView addSubview:self.confirmBtn];
    [self.bgView addSubview:self.dividerView];
    [self.bgView addSubview:self.timePicker];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height - 88);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView);
        make.centerY.equalTo(@[self.cancelBtn, self.confirmBtn]);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(58);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(28);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-28);
    }];
    [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(58);
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(1);
    }];
    [self.timePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.dividerView.mas_bottom);
        make.left.equalTo(self.bgView).offset(19);
        make.right.equalTo(self.bgView).offset(-19);
        make.centerY.equalTo(self.bgView);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height * 3 /4);
    }];
    [self.timePicker layoutIfNeeded];
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] init];
    label.font = self.pickerFont;
    label.textColor = self.pickerColor;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = [NSString stringWithFormat:@"%ld年",self.defaultDate.year - 501 + row];
    }else if (component == 1) {
        label.text = [NSString stringWithFormat:@"%ld月", row % 12 + 1];
    }else if (component == 2) {
        label.text = [NSString stringWithFormat:@"%ld日",row % 31 + 1];
    }else if (component == 3) {
        label.text = [NSString stringWithFormat:@"%ld时",row % 24];
    }else if (component == 4) {
        label.text = [NSString stringWithFormat:@"%ld分",row % 60 ];
    }else if (component == 5) {
        label.text = [NSString stringWithFormat:@"%ld秒",row % 60];
    }
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 68;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return  [self getWidthForComponent:component];
}

- (CGFloat)getWidthForComponent:(NSInteger)component{
    if (component == 0) {
        return UIScreen.mainScreen.bounds.size.width / 6;
    }
    if (self.mode == TimeModle_YMDHMS) {
        return UIScreen.mainScreen.bounds.size.width / 8;
    }
    
    return UIScreen.mainScreen.bounds.size.width / 6;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.selectYear = row - 501 + self.defaultDate.year;
    }
    if (component == 1) {
        self.selectMonth = row % 12 + 1;
    }
    if (component == 2) {
        self.selectDay = row % 31 + 1;
    }
    if (component == 3) {
        self.selectHour = row % 24;
    }
    if (component == 4) {
        self.selectMinute = row % 60;
    }
    if (component == 5) {
        self.selectSecond = row % 60;
    }
    
    [self checkDate:row];
    [self checkMaxDate:row];
    [self checkMinDate:row];
}

- (void)checkDate:(NSInteger)row{
    bool isReturn = false;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:self.selectYear];
    [components setMonth:self.selectMonth];
    NSInteger days = [calendar dateFromComponents:components].day;
    if (self.selectDay > days) {
        self.selectDay = days;
        isReturn = true;
    }
    [components setDay:self.selectDay];
    [components setHour:self.selectHour];
    [components setMinute:self.selectMinute];
    [components setSecond:self.selectSecond];
    NSDate *selectDate = [calendar dateFromComponents:components];
    
    if (isReturn) {
        [self configSelectRow:selectDate YearRow:row - (self.selectYear - self.maxDate.year) IsScroll:false];
        return;
    }
}

- (void)checkMaxDate:(NSInteger)row{
    if (!self.maxDate || self.maxDate == nil) {
        return;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:self.selectYear];
    [components setMonth:self.selectMonth];
    [components setDay:self.selectDay];
    if ([[calendar dateFromComponents:components] compare:self.maxDate] == NSOrderedDescending) {
        [self configSelectRow:self.maxDate YearRow:row - (self.selectYear - self.maxDate.year) IsScroll:true];
    }
}

- (void)checkMinDate:(NSInteger)row{
    if (!self.minDate || self.minDate == nil) {
        return;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:self.selectYear];
    [components setMonth:self.selectMonth];
    [components setDay:self.selectDay];
    if ([self.minDate compare:[calendar dateFromComponents:components]] == NSOrderedDescending) {
        [self configSelectRow:self.minDate YearRow:row + (self.minDate.year - self.selectYear) IsScroll:true];
    }
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [self getNumberOfComponents];
}

- (NSInteger)getNumberOfComponents{
    switch (self.mode) {
        case TimeModle_Y:
            return 1;
            break;
        case TimeModle_YM:
            return 2;
            break;
        case TimeModle_YMD:
            return 3;
            break;
        case TimeModle_YMDH:
            return 4;
            break;
        case TimeModle_YMDHM:
            return 5;
            break;
        case TimeModle_YMDHMS:
            return 6;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self getNumberOfRowsInComponent:component];
}

- (NSInteger)getNumberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 1000;
    }else if (component == 1) {
        return 12 * 1000;
    }else if (component == 2) {
        return 31 * 1000;
    }else if (component == 3) {
        return 24 * 1000;
    }else if (component == 4) {
        return 60 * 1000;
    }else if (component == 5) {
        return 60 * 1000;
    }
    return 0;
}

#pragma mark - UILazy
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    
    return _bgView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor colorHex:@"#999999"] forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor colorHex:@"#999999"] forState:(UIControlStateSelected)];
        [_cancelBtn setTitleColor:[UIColor colorHex:@"#999999"] forState:(UIControlStateHighlighted)];
        _cancelBtn.titleLabel.font = [UIFont systemMediumFont:14];
    }
    
    return _cancelBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"";
        _titleLabel.font = [UIFont systemMediumFont:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_confirmBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        [_confirmBtn setTitleColor:[UIColor colorHex:@"#0066FF"] forState:(UIControlStateNormal)];
        [_confirmBtn setTitleColor:[UIColor colorHex:@"#0066FF"] forState:(UIControlStateSelected)];
        [_confirmBtn setTitleColor:[UIColor colorHex:@"#0066FF"] forState:(UIControlStateHighlighted)];
        _confirmBtn.titleLabel.font = [UIFont systemMediumFont:14];
    }
    
    return _confirmBtn;
}

- (UIView *)dividerView{
    if (!_dividerView) {
        _dividerView = [[UIView alloc]init];
        _dividerView.backgroundColor = [UIColor colorHex:@"#000000" alpha:0.05];
    }
    
    return _dividerView;
}

- (UIPickerView *)timePicker{
    if (!_timePicker) {
        _timePicker = [[UIPickerView alloc] init];
        _timePicker.delegate = self;
        _timePicker.dataSource = self;
        _timePicker.showsSelectionIndicator = false;
        
    }
    
    return _timePicker;
}


@end
