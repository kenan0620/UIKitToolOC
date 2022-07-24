//
//  PopConfig.h
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (PopConfig *)sharedConfig;

/// 左右弹框时，间距
@property (nonatomic, assign) CGFloat popSpace;
/// 居中弹框时，间距
@property (nonatomic, assign) CGFloat popCenterSpace;
/// 弹框视图圆角
@property (nonatomic, assign) CGFloat cornerRadius;
/// 动画时间
@property (nonatomic, assign) CGFloat animationTime;
/// 背景透明颜色
@property (nonatomic, strong) UIColor *bgColor;
/// 视图背景颜色
@property (nonatomic, strong) UIColor *popBgViewColor;

@end

NS_ASSUME_NONNULL_END
