//
//  PopVC.h
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PopType_Top = 0,
    PopType_Center,
    PopType_Bottom,
    PopType_Left,
    PopType_Right,
} PopType;
/// 弹框出现动画方式
@interface PopVC : UIView
/**
 弹出视图
 
 @param popView 视图
 @param popType 弹出格式
 */
+ (instancetype)presentView:(UIView *)popView
                    PopType:(PopType)popType;

/**
 弹出视图在view上
 
 @param popView 视图
 @param popType 弹出格式
 */
+ (instancetype)presentAtView:(UIView *)popView
                    PopType:(PopType)popType;

/**
 视图消失
 */
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
