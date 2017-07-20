//
//  CallsAPIRESTfulService.m
//  Patrol
//
//  Created by 李林峰 on 2017/5/8.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "CallsAPIRESTfulService.h"
#import "CallsAPIURL.h"

static CallsAPIRESTfulService * _sharedSingleton = nil;
static BOOL isFirstAccess = YES;

@implementation CallsAPIRESTfulService
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)sharedSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedSingleton];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedSingleton];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedSingleton];
}

- (id)copy
{
    return [[[self class] alloc] init];
}

- (id)mutableCopy
{
    return [[[self class] alloc] init];
}

- (id)init
{
    if(_sharedSingleton){
        return _sharedSingleton;
    }
    if (isFirstAccess) {
        NSAssert(NO, @"Cannot create instance of Singleton");
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

- (void)busyCallWithCallerID:(NSString *)caller
                restultBlock:(void (^)(ServiceResultInfo *statusInfo))completions {
    NSDictionary *dicParamter = @{@"caller_id" : caller};
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_CALL_BUSY
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
                                 }];
}

/**
 startCall(主叫)
 @param  callee_id        被call者的 id
 @param  call_type        callType_videoCall/callType_audioCall
*/
- (void)startCallWithCalleeID:(NSString *)callee_id callType:(NSUInteger)call_type resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{
    
    NSDictionary * dicParamter = @{
                                   @"callee_id" : callee_id,
                                   @"call_type" : [NSNumber numberWithUnsignedInteger:call_type],};
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_CALL_START
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

///endCall  ///正常结束通话
- (void)endCallWithUserID:(NSString *)user resultBlock:(void (^)(ServiceResultInfo * statusInfo))completions
{
    NSDictionary *dicParamter = @{@"user_id" : user};
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_CALL_END
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

///acceptCall
- (void)acceptCallWithCallerID:(NSString *)caller resultBlock:(void (^)(ServiceResultInfo * statusInfo))completions
{
    NSDictionary *dicParamter = @{@"caller_id" : caller};
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_CALL_ACCEPT
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
                                 }];
}

///rejectCall
- (void)rejectCallWithCallerID:(NSString *)caller resultBlock:(void (^)(ServiceResultInfo * statusInfo))completions
{
    NSDictionary *dicParamter = @{@"caller_id" : caller};
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_CALL_REJECT
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
                                 }];
}
@end
