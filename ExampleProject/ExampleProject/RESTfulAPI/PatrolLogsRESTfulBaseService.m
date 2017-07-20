//
//  PatrolLogsRESTfulBaseService.m
//  Patrol
//
//  Created by 李林峰 on 2017/5/9.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "PatrolLogsRESTfulBaseService.h"
#import "PatrolLogsAPIURL.h"
#import "PatrolModel.h"

static PatrolLogsRESTfulBaseService * _sharedSingleton = nil;
static BOOL isFirstAccess = YES;

@implementation PatrolLogsRESTfulBaseService
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

///start daily patrol ,success return patrolID
- (void)startDailyPatrolResultBlock:(void (^)(ServiceResultInfo *statusInfo))completions {
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_START_DAILYPATROL
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         //缓存patrolID
                                         [CoreStore sharedStore].patrolID = responsedata[@"id"];
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

///endCurrentPatrol
- (void)endCurrentPatrolResultBlock:(void (^)(ServiceResultInfo *statusInfo))completions {
    
    NSString * patrolID = [CoreStore sharedStore].patrolID;
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_END_CURRENTPATROL(patrolID)
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                     
                                         //当重新进入app if(patrolid == nil){the button show "开始巡检"}else{the button show "结束巡检"}
                                         [CoreStore sharedStore].patrolID = nil;
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

///get current patrol logs,will return logs//HOME页本次巡检的记录
- (void)getCurrentPatrolLogsresultBlock:(void (^)(ServiceResultInfo *statusInfo,PatrolCurrent *currentPatrol))completions {
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_GET
                                      urlResource:URL_GET_CURRENT_PATROLLOGS
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     if (resultStatusInfo.finishStatus) {

                                         PatrolCurrent *patrol = [PatrolCurrent objectWithJSON:responsedata];
                                         completions(resultStatusInfo, patrol);
                                     }else{
                                         completions(resultStatusInfo, nil);
                                     }
                                 }];
}
///get patrol logs with the date
- (void)getPatrolLogsWiththeDate:(NSString *)dateStr pageInfo:(PageInfoModel *)pageIndex resultBlock:(void (^)(ServiceResultInfo *statusInfo, NSArray *dates, NSArray *logs, PageInfoModel *pageInfo))completions {
    
    NSMutableDictionary * dicParameters = [NSMutableDictionary dictionaryWithDictionary:[self buildingPageIndex:pageIndex]];
    [dicParameters setObject:dateStr forKey:@"q_date"];
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_GET
                                      urlResource:URL_GET_LOGS_DATE
                                    urlParameters:dicParameters
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     if (resultStatusInfo.finishStatus) {
                                         NSLog(@"responsedata = %@",responsedata);
                                         PageInfoModel *pageInfo = [PageInfoModel jsonDataWithModel:responsedata[@"page"]];
                                         NSArray *logs = [PatrolLogHistory jsonDataWithModel:responsedata[@"logs"]];
                                         NSArray *dates = responsedata[@"dates"];;
                                         completions(resultStatusInfo, dates, logs, pageInfo);
                                     }else {
                                         completions(resultStatusInfo, nil, nil, nil);
                                     }
                                 }];
}

/**
 add patrol point
 @paramter description     descriptionString
 @paramter address         chineseAddressString
 @paramter latitude        latitude
 @paramter longitude       longitude
 @paramter mediaArray      mediaUUIDArray
 */
- (void)addPatrolPointWithDescription:(NSString *)string addressCH:(NSString *)addr latitude:(NSDecimalNumber *)lat longitude:(NSDecimalNumber *)lng mediaArray:(NSArray *)mediaArray resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions {
    
    if (!mediaArray) {
        mediaArray = @[];
    }
    NSString * patrolID = [CoreStore sharedStore].patrolID;
    NSDictionary * dicParameters = @{@"description" : string,
                                            @"addr" : addr,
                                             @"lat" : lat,
                                             @"lng" : lng,
                                           @"media" : mediaArray};
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_ADD_PATROLPOINT(patrolID)
                                    urlParameters:dicParameters
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

//delete PatrolPoint with itemID
- (void)deletePatrolPointWithPatrolPointItemID:(NSString *)item_id resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions {
    
    NSString * patrolID = [CoreStore sharedStore].patrolID;
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_DELETE
                                      urlResource:URL_DELETE_PATROLPOINT(patrolID, item_id)
//                                    urlParameters:nil
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

///modify patrol point logs with itemID
- (void)modifyPatrolPointWithDescription:(NSString *)string itemID:(NSString *)item_id mediaArray:(NSArray *)mediaArray resultBlock:(void (^)(ServiceResultInfo *))completions {
    
    if (!mediaArray) {
        mediaArray = @[];
    }
    NSString * patrolID = [CoreStore sharedStore].patrolID;
    NSDictionary * dicParameters = @{@"description" : string,
                                     @"media" : mediaArray};
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_PUT
                                      urlResource:URL_PUT_EDIT_PATROLPOINT(patrolID, item_id)
                                    urlParameters:dicParameters
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
        
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}


@end
