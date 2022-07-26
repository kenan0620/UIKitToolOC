//
//  Request.m
//  UIKitToolOC
//
//  Created by 柯南 on 2022/7/26.
//

#import "Request.h"

#import "NetworkConfig.h"
#import <YTKNetwork/YTKNetworkAgent.h>

@implementation Request
- (void)start{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    NSString *keypath = @"jsonResponseSerializer.acceptableContentTypes";
    [agent setValue:[NetworkConfig sharedConfig].contentTypes forKeyPath:keypath];
    [super start];
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return [NetworkConfig sharedConfig].headerDic;
}

- (id)requestArgument {
    NSMutableDictionary *mutabDic = [NSMutableDictionary dictionary];
    if (self.param) {
        [mutabDic addEntriesFromDictionary:self.param];
    }
    if ([NetworkConfig sharedConfig].commonParam) {
        [mutabDic addEntriesFromDictionary:[NetworkConfig sharedConfig].commonParam];
    }
    
    return mutabDic;
}

- (void)setMethod:(RequestMethod)method{
    _method = method;
}

- (YTKRequestMethod)requestMethod{
    switch (self.method) {
        case RequestMethodGET:
            return  YTKRequestMethodGET;
            break;
        case RequestMethodPOST:
            return  YTKRequestMethodPOST;
            break;
        case RequestMethodHEAD:
            return  YTKRequestMethodHEAD;
            break;
        case RequestMethodPUT:
            return  YTKRequestMethodPUT;
            break;
        case RequestMethodDELETE:
            return  YTKRequestMethodDELETE;
            break;
        case RequestMethodPATCH:
            return  YTKRequestMethodPATCH;
            break;
    }
    return YTKRequestMethodGET;
}

- (void)requestData{
    self.delegate = self;
    [self start];
}

- (NSString *)requestUrl {
    return self.url;
}
@end
