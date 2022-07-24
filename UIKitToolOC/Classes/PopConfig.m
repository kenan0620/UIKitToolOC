//
//  PopConfig.m
//  UIKitToolOC
//
//  Created by zsn on 2022/7/24.
//

#import "PopConfig.h"

@implementation PopConfig

+ (PopConfig *)sharedConfig {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _popSpace = 100;
        _popCenterSpace = 14;
        _cornerRadius = 15;
        _animationTime = 0.25;
        _bgColor = [UIColor colorWithWhite:0 alpha:0.5];
        _popBgViewColor = [UIColor whiteColor];
    }
    return self;
}
@end
