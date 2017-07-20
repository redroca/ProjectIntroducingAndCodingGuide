//
//  LoginAPIRESTfulService.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/5.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "RESTfulBaseService.h"
#import "UserModel.h"
@class PageInfoModel;

@interface LoginAPIRESTfulService : RESTfulBaseService

+ (instancetype)sharedSingleton;

///loginAPI(getAccessToken)
- (void)loginWithPhoneNumberString:(NSString *)phoneNumberString password:(NSString *)password resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///getUserInfo
- (void)getUserInfoResultBlock:(void (^)(ServiceResultInfo *statusInfo, UserBaseModel *user))completions;

///signout
- (void)signoutWithResultBlock:(void (^)(ServiceResultInfo * statusInfo))completions;

///getCurrentTeamContacts
- (void)getCurrentTeamContactsWithPageInfo:(PageInfoModel *)index resultBlock:(void (^)(ServiceResultInfo *statusInfo, PageInfoModel *pageInfo, NSMutableArray *contacts))completions;

///Update userInfo
- (void)postUpdateUserInfo:(NSMutableDictionary *) dictpatameters resultBlock:(void (^)(ServiceResultInfo *statusInfo, UserBaseModel *userInfo))completions;
- (void)uploadMyIconBadgeImg:(UIImage *) iconImg resultBlock:(void (^)(BOOL finish, NSString *iconURL))completions;

//- (void)joinTheTeamWithTeamID:(NSString *)team_id string:(NSString *)string resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;


/**
 *  clear Cache data and reset data when logout success.
 */
- (void)logoutCleanupUserData;

@end
