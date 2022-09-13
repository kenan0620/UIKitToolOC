//
//  IDCardTextField.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDCardTextField : UITextField
/**
 键盘点击事件

 @param value 输入的身份证号内容
 @param inputLimit 输入的身份证号长度是否超长，(返回TRUE的情况下进行提示等)
 @param isVaild 身份证号是否真实有效
 */
@property (nonatomic, copy) void(^idcardBlock)(NSString *idcard, BOOL inputLimit, BOOL isValid);

/// 设置默认身份证号(可以设置部分)
@property (nonatomic, copy) NSString *idCard;
@end

NS_ASSUME_NONNULL_END
