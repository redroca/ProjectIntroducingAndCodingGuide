//
//  PatrolLogsRESTfulBaseService.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/9.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "RESTfulBaseService.h"

@class PatrolCurrent;

@interface PatrolLogsRESTfulBaseService : RESTfulBaseService

+ (instancetype)sharedSingleton;

///start daily patrol
- (void)startDailyPatrolResultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///end current patrol
- (void)endCurrentPatrolResultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;
//- (void)endCurrentPatrolWithpatrolID:(NSString *)patrolID resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///get current patrol logs,will return logs
- (void)getCurrentPatrolLogsresultBlock:(void (^)(ServiceResultInfo *statusInfo,PatrolCurrent *currentPatrol))completions;

///get patrol logs with the date
- (void)getPatrolLogsWiththeDate:(NSString *)dateStr pageInfo:(PageInfoModel *)pageIndex resultBlock:(void (^)(ServiceResultInfo *statusInfo, NSArray *dates, NSArray *logs, PageInfoModel *pageInfo))completions;

/**
 add patrol point
 @paramter description     descriptionString
 @paramter address         chineseAddressString
 @paramter latitude        latitude 
 @paramter longitude       longitude
 @paramter mediaArray      mediaUUIDArray
 */
- (void)addPatrolPointWithDescription:(NSString *)string addressCH:(NSString *)addr latitude:(NSDecimalNumber *)lat longitude:(NSDecimalNumber *)lng mediaArray:(NSArray *)mediaArray resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

//delete PatrolPoint with itemID
- (void)deletePatrolPointWithPatrolPointItemID:(NSString *)item_id resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

/**
 modify patrol point logs with itemID
 @paramter description     descriptionString
 @paramter mediaArray      mediaUUIDArray
 */
- (void)modifyPatrolPointWithDescription:(NSString *)string itemID:(NSString *)item_id mediaArray:(NSArray *)mediaArray resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;



@end
