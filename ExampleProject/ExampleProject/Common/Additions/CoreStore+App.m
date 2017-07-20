//
//  CoreStore+App.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreStore+App.h"
#import "CommonAppHeaders.h"

@implementation CoreStore (App)
/////////////////////////////get///////////////////////////////////

- (BOOL)isLogin{
    return [self BOOLDataForKey:APP_IS_LOGIN];
}

- (BOOL)isFirstAuthrization
{
    return [self BOOLDataForKey:APP_FIRST_AUTHRIZATION];
}

- (NSString *)patrolAccessToken{
    return [self stringDataForKey:APP_ACCESS_TOKEN];
}

- (NSString *)patrolID{
    return [self stringDataForKey:APP_PATROL_ID];
}

- (NSString *)recentlyPhoneNum{
    return [self stringDataForKey:APP_RECENTLY_PHONENUMBER];
}

/////////////////////////////set///////////////////////////////////

- (void)setIsLogin:(BOOL)isLogin{
    [self setBOOLData:isLogin forKey:APP_IS_LOGIN];
}

- (void)setIsFirstAuthrization:(BOOL)isFirstAuthrization
{
    [self setBOOLData:isFirstAuthrization forKey:APP_FIRST_AUTHRIZATION];
}

- (void)setPatrolAccessToken:(NSString *)patrolAccessToken{
    [self setStringData:patrolAccessToken forKey:APP_ACCESS_TOKEN];
}

- (void)setPatrolID:(NSString *)patrolID{
    [self setStringData:patrolID forKey:APP_PATROL_ID];
}

- (void)setRecentlyPhoneNum:(NSString *)recentlyPhoneNum{
    [self setStringData:recentlyPhoneNum forKey:APP_RECENTLY_PHONENUMBER];
}

@end
