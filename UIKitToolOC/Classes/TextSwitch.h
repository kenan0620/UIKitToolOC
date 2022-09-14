//
//  TextSwitch.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/9/14.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SwitchStyleNoBorder,
    SwitchStyleBorder
} SwitchStyle;

NS_ASSUME_NONNULL_BEGIN

@interface TextSwitch : UIControl
/// 是否有边框
@property (nonatomic, assign) SwitchStyle style;

/// Switch开的背景颜色
@property (nonatomic, strong) UIColor *onTintColor;
/// 字体颜色
@property (nonatomic, strong) UIColor *onTextColor;
/// 文字
@property (nonatomic, strong) NSString *onText;

/// Switch关的背景颜色
@property (nonatomic, strong) UIColor *tintColor;
/// 字体颜色
@property (nonatomic, strong) UIColor *offTextColor;
/// 文字
@property (nonatomic, strong) NSString *offText;

/// 字体大小
@property (nonatomic, strong) UIFont *textFont;

/// Switch开关圆形部位的颜色
@property (nonatomic, strong) UIColor *thumbTintColor;

/// 获取状态
@property (nonatomic, assign, getter = isOn) BOOL on;
/// 设置Switch状态
- (void)setOn:(BOOL)on animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
