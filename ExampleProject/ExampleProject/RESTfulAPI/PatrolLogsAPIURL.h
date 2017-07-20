//
//  PatrolLogsAPIURL.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/9.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "BaseAPIURL.h"

///add patrol point
#define URL_POST_ADD_PATROLPOINT(i)             [NSString stringWithFormat:@"%@/patrol_logs/%@/items%@",RESTFUL_BASE_HOST,i,RESTFUL_SUFFIX_TOKEN]

///delete patrol point
#define URL_DELETE_PATROLPOINT(i,j)             [NSString stringWithFormat:@"%@/patrol_logs/%@/items/%@%@", RESTFUL_BASE_HOST,i,j,RESTFUL_SUFFIX_TOKEN]

///edit patrol point
#define URL_PUT_EDIT_PATROLPOINT(i,j)           [NSString stringWithFormat:@"%@/patrol_logs/%@/items/%@%@", RESTFUL_BASE_HOST,i,j,RESTFUL_SUFFIX_TOKEN]

///get current patrol logs
#define URL_GET_CURRENT_PATROLLOGS              [NSString stringWithFormat:@"%@/patrol_logs/current%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///start daily patrol
#define URL_POST_START_DAILYPATROL              [NSString stringWithFormat:@"%@/patrol_logs/start_daily%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///end current patrol
#define URL_POST_END_CURRENTPATROL(i)           [NSString stringWithFormat:@"%@/patrol_logs/%@/end%@", RESTFUL_BASE_HOST,i,RESTFUL_SUFFIX_TOKEN]

///get history logs
#define URL_GET_LOGS_DATE                       [NSString stringWithFormat:@"%@/patrol_logs%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
