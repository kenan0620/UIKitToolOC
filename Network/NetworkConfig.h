//
//  NetworkConfig.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkConfig : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (NetworkConfig *)sharedConfig;

/// 配置请求头
@property (nonatomic, copy) NSDictionary *headerDic;
/// 配置公共参数
@property (nonatomic, copy) NSDictionary *commonParam;
/// 配置格式
@property (nonatomic, copy) NSSet *contentTypes;
///  Request base URL, such as "http://www.yuantiku.com". Default is empty string.
@property (nonatomic, strong) NSString *baseUrl;
///  Request CDN URL. Default is empty string.
@property (nonatomic, strong) NSString *cdnUrl;
///  Whether to log debug info. Default is NO;
@property (nonatomic) BOOL debugLogEnabled;
@end

NS_ASSUME_NONNULL_END
