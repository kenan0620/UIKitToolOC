//
//  NetworkConfig.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/7/26.
//

#import "NetworkConfig.h"
#import <YTKNetwork/YTKNetworkConfig.h>

@implementation NetworkConfig
+ (NetworkConfig *)sharedConfig {
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
        _headerDic = @{};
        _commonParam = @{};
        _contentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    }
    return self;
}

- (void)setHeaderDic:(NSDictionary *)headerDic{
    _headerDic = headerDic;
}

- (void)setCommonParam:(NSDictionary *)commonParam{
    _commonParam = commonParam;
}

- (void)setContentTypes:(NSSet *)contentTypes{
    _contentTypes = contentTypes;
}

- (void)setBaseUrl:(NSString *)baseUrl{
    _baseUrl = baseUrl;
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = _baseUrl;
}

- (void)setCdnUrl:(NSString *)cdnUrl{
    _cdnUrl = cdnUrl;
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.cdnUrl = _cdnUrl;
}

- (void)setDebugLogEnabled:(BOOL)debugLogEnabled{
    _debugLogEnabled = debugLogEnabled;
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.debugLogEnabled = _debugLogEnabled;
}
@end
