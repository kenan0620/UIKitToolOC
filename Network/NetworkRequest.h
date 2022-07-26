//
//  NetworkRequest.h
//  UIKitToolOC
//
//  Created by 柯南 on 2022/7/26.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN
///  HTTP Request method.
typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGET = 0,
    RequestMethodPOST,
    RequestMethodHEAD,
    RequestMethodPUT,
    RequestMethodDELETE,
    RequestMethodPATCH,
};

@interface NetworkRequest : YTKRequest<YTKRequestDelegate>
/// 请求地址
@property (nonatomic, copy) NSString *url;
/// 请求参数
@property (nonatomic, copy) NSDictionary *param;
/// 请求方式
@property (nonatomic, assign) RequestMethod method;
/// 请求入口
- (void)requestData;

@end

NS_ASSUME_NONNULL_END
