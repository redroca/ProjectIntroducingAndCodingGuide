//
//  CallsAPIURL.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/8.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "BaseAPIURL.h"

///busy call
#define URL_POST_CALL_BUSY            [NSString stringWithFormat:@"%@/calls/busy%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///start call
#define URL_POST_CALL_START           [NSString stringWithFormat:@"%@/calls/start%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///end call （？？？正常结束通话。注意这里通话其实没有真正意义上的开始？？？）
#define URL_POST_CALL_END             [NSString stringWithFormat:@"%@/calls/end%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///被叫方接受
#define URL_POST_CALL_ACCEPT          [NSString stringWithFormat:@"%@/calls/accept%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///被叫方拒绝
#define URL_POST_CALL_REJECT          [NSString stringWithFormat:@"%@/calls/reject%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///获取最后一条通话请求.
#define URL_Get_CALL_REQUEST          [NSString stringWithFormat:@"%@/calls/calling%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
