//
//  RichConfig.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/10/20.
//

#import "RichConfig.h"

#import <YYText/YYText.h>

@implementation RichConfig
+ (NSMutableAttributedString *)getRegularGrayAttr:(NSString *)text{
    return [self getAttr:text Font:[UIFont systemFontOfSize:14 weight:(UIFontWeightRegular)] Color:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.00]];
}

+ (NSMutableAttributedString *)getMediumBlackAttr:(NSString *)text{
    return [self getAttr:text Font:[UIFont systemFontOfSize:14 weight:(UIFontWeightMedium)] Color:[UIColor blackColor]];
}

+ (NSMutableAttributedString *)getAttr:(NSString *)text
                                  Font:(nullable UIFont *)font
                                 Color:(nullable UIColor *)color{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:text];
    [attr yy_setFont:font == nil ? [UIFont systemFontOfSize:14 weight:(UIFontWeightMedium)] : font range:range];
    [attr yy_setColor:color == nil ? [UIColor blackColor] : color range:range];
    
    return  attr;
}
@end
