//
//  CallsAPIRESTfulService.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/8.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "RESTfulBaseService.h"

static NSUInteger const callType_videoCall = 0;
static NSUInteger const callType_audioCall = 1;

@interface CallsAPIRESTfulService : RESTfulBaseService

+ (instancetype)sharedSingleton;

//busyCall
- (void)busyCallWithCallerID:(NSString *)callee restultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///startCall
- (void)startCallWithCalleeID:(NSString *)callee_id callType:(NSUInteger)call_type resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///endCall
- (void)endCallWithUserID:(NSString *)user resultBlock:(void (^)(ServiceResultInfo * statusInfo))completions;

///acceptCall
- (void)acceptCallWithCallerID:(NSString *)caller resultBlock:(void (^)(ServiceResultInfo * statusInfo))completions;

///rejectCall
- (void)rejectCallWithCallerID:(NSString *)caller resultBlock:(void (^)(ServiceResultInfo * statusInfo))completions;

@end
