//
//  KeyboardIDCardView.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardIDCardView : UIView
/**
 键盘点击事件

 @param idcard 输入的身份证号内容
 @param cursorLocation 输入的光标位置
 @param inputLimit 输入的身份证号长度是否超长，(返回TRUE的情况下进行提示等)
 @param isVaild 身份证号是否真实有效
 */
@property (nonatomic, copy) void(^idcardBlock)(NSString *idcard, int cursorLocation, BOOL inputLimit, BOOL isValid);

/// 光标位置(设置初始位置即可，用于中间插入数字及删除)
@property (nonatomic, assign) int cursorLocation;
/// 键盘背景色
@property (nonatomic, copy) UIColor *keyBoardBgColor;
/// 删除按钮图片
@property (nonatomic, copy) UIImage *deleteImage;
/// 删除文字
@property (nonatomic, copy) NSString *deleteText;
/// 删除文字颜色
@property (nonatomic, copy) UIColor *deleteTextColor;
/// 设置身份证号
@property (nonatomic, copy) NSString *idCard;
@end

NS_ASSUME_NONNULL_END
