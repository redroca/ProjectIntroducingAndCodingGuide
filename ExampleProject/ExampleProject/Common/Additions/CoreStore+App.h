//
//  CoreStore+App.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "CoreStore.h"

@interface CoreStore (App)

#define APP_ACCESS_TOKEN                 @"app_access_token"
#define APP_PATROL_ID                    @"app_patrol_id"
#define APP_IS_LOGIN                     @"app_is_log"
#define APP_FIRST_AUTHRIZATION           @"app_first_authrization"       //first time show authrization
#define APP_RECENTLY_PHONENUMBER         @"app_recently_phonenumber"
#define APP_USER_BASE_INFO               @"app_user_base_info"

@property (nonatomic, assign)    BOOL           isLogin;
@property (nonatomic, assign)    BOOL          isFirstAuthrization;

@property (nonatomic, copy)      NSString       *patrolAccessToken;
@property (nonatomic, copy)      NSString       *patrolID;
@property (nonatomic, copy)      NSString       *recentlyPhoneNum;
@end
