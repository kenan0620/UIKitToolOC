//
//  RichConfig.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichConfig : NSObject
/**
 获取标题灰  14 regular  lightGrayTextColor
 
 @param text 文本内容
 */
+ (NSMutableAttributedString *)getRegularGrayAttr:(NSString *)text;
/**
 获取内容黑
 
 @param text 文本内容 14 medium black
 */
+ (NSMutableAttributedString *)getMediumBlackAttr:(NSString *)text;
/**
 获取富文本
 
 @param text 文本内容
 @param font 文本字体 默认 14 medium
 @param color 文本颜色 默认 black
 */
+ (NSMutableAttributedString *)getAttr:(NSString *)text
                                  Font:(nullable UIFont *)font
                                 Color:(nullable UIColor *)color;
@end

NS_ASSUME_NONNULL_END
