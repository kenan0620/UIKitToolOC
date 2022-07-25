//
//  TimePicker.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/7/25.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TimePickerMode) {
    /// 年
    TimeModle_Y,
    /// 年月
    TimeModle_YM,
    /// 年月日
    TimeModle_YMD,
    /// 年月日时
    TimeModle_YMDH,
    /// 年月日时分
    TimeModle_YMDHM,
    /// 年月日时分秒
    TimeModle_YMDHMS,
};

NS_ASSUME_NONNULL_BEGIN

@protocol TimePickerDelegate <NSObject>

/**
 @brief 确认操作
 
 @param date 日期NSDate
 @param target 用于区分pickerView
 */
- (void)confirmActionWithDate:(NSDate *)date withTarget:(NSInteger)target;

/**
 @brief 取消操作
 
 @param target 用于区分pickerView
 */
- (void)cancelActionWithTarget:(NSInteger)target;
@end

@interface TimePicker : UIView
#pragma mark - Date
///限制最大时间
@property (nonatomic, strong) NSDate *maxDate;
///限制最小时间
@property (nonatomic, strong) NSDate *minDate;
///默认时间 - - 默认当前时间
@property (nonatomic, strong) NSDate *defaultDate;

#pragma mark - Other
@property (nonatomic, weak) id<TimePickerDelegate> delegate;
/// 选择器的枚举
@property (nonatomic, assign) TimePickerMode mode;
/// pickerView的tag  用于回调区分
@property (nonatomic, assign) NSInteger target;

#pragma mark - UI

/// 是否展示分割线
@property (nonatomic, assign) bool isShowLine;

///确定按钮文本 默认保存
@property (nonatomic, copy) NSString *confirmText;
///确定按钮颜色 默认0066FF
@property (nonatomic, strong) UIColor *confirmColor;
///确定按钮字体 默认Medium 14
@property (nonatomic, strong) UIFont *confirmFont;

///取消按钮文本 默认取消
@property (nonatomic, copy) NSString *cancelText;
///取消按钮颜色 默认999999
@property (nonatomic, strong) UIColor *cancelColor;
///取消按钮字体 默认Medium 14
@property (nonatomic, strong) UIFont *cancelFont;

///标题文本 默认 ""
@property (nonatomic, copy) NSString *title;
///标题颜色 默认黑色
@property (nonatomic, strong) UIColor *titleColor;
///标题字体 默认Medium18
@property (nonatomic, strong) UIFont *titleFont;

#pragma mark - Picker
///滚轮日期文本颜色(默认black)
@property (nonatomic, strong) UIColor *pickerColor;
///滚轮日期文本字体[UIFont systemFontOfSize:16]
@property (nonatomic, strong) UIFont *pickerFont;

@end

NS_ASSUME_NONNULL_END
