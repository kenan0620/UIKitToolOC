//
//  DecimalTextField.h
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    /// 最大值触发禁止输入
    ForbidType_Value,
    /// 最大位数触发禁止输入
    ForbidType_Length,
    /// 小数位数最大值触发禁止输入
    ForbidType_DecimalLength,
} ForbidType;

@protocol DecimalTextFieldDelegate <NSObject>

/**
 禁止输入原因
 
 @param type 原因类型
 */
- (void)decimalTF_ForbidWithType:(ForbidType)type;
@end

@interface DecimalTextField : UITextField
/// 外部不要使用系统代理，会导致设置无效
@property (nonatomic, weak) id<DecimalTextFieldDelegate> decimalDelegate;
/// 整数位最大数
@property (nonatomic, assign) NSInteger maxValue;
/// 整数位最大位数
@property (nonatomic, assign) NSInteger maxLength;
/// 小数位最大位数
@property (nonatomic, assign) NSInteger maxDecimalLength;

@end

NS_ASSUME_NONNULL_END
