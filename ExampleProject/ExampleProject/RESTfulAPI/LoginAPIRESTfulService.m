//
//  LoginAPIRESTfulService.m
//  Patrol
//
//  Created by 李林峰 on 2017/5/5.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "LoginAPIRESTfulService.h"
#import "LoginAPIURL.h"

static LoginAPIRESTfulService * _sharedSingleton = nil;
static BOOL isFirstAccess = YES;

#define GRANT_TYPE      @"password"

@implementation LoginAPIRESTfulService
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

- (void)loginWithPhoneNumberString:(NSString *)phoneNumberString password:(NSString *)password resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{
    
    NSDictionary *dicParameters = @{@"grant_type"   : GRANT_TYPE,
                                    @"client_id"    : CLIENT_ID,
                                    @"client_secret": CLIENT_SECRET,
                                    @"mobile"       : phoneNumberString,
                                    @"password"     : password,};
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_GETACCESSTOKEN
                                    urlParameters:dicParameters
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         NSString * accessToken = responsedata[@"access_token"];
                                         NSLog(@"accessToken = %@",accessToken);
                                         //缓存accessToken
                                         [CoreStore sharedStore].patrolAccessToken = accessToken;
                                         [CoreStore sharedStore].isLogin = YES;
                                         [CoreStore sharedStore].recentlyPhoneNum = phoneNumberString;
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}
///get userInfo
- (void)getUserInfoResultBlock:(void (^)(ServiceResultInfo *statusInfo, UserBaseModel *user))completions{
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_GET
                                      urlResource:URL_GET_USERINFO
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         UserBaseModel *user = [UserBaseModel objectWithJSON:responsedata];
                                         [CoreStore sharedStore].userBaseModel = user;
                                         completions(resultStatusInfo, user);
                                     }else{
                                         completions(resultStatusInfo, nil);
                                     }
    }];
}

///signout API
- (void)signoutWithResultBlock:(void (^)(ServiceResultInfo * statusInfo))completions{
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_DELETE
                                      urlResource:URL_DELETE_SIGNOUT
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                     
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
    }];
}

///**
// Update userInfo API
// @param notification_token    JPushToken
// @param lat                   latitude
// @param lng                   longitude
// @param avatar                userAvatar
// */
//- (void)updateUserInfoWithNotificationToken:(NSString *)notification_token latitude:(CGFloat)lat longitude:(CGFloat)lng userAvatar:(id)avatar resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{
//    
//    NSDictionary * dicParameter = @{@"notification_token" : notification_token,
//                                                   @"lat" : [NSDecimalNumber numberWithFloat:lat],
//                                                   @"lng" : [NSDecimalNumber numberWithFloat:lng],
//                                                @"avatar" : avatar};
//    
//    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
//                                      urlResource:URL_POST_UPDATEUSERINFO
//                                    urlParameters:dicParameter
//                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
//                                     
//                                     if (resultStatusInfo.finishStatus) {
//                                         
//                                         completions(resultStatusInfo);
//                                     }else{
//                                         
//                                         completions(resultStatusInfo);
//                                     }
//    }];
//}

- (void)postUpdateUserInfo:(NSMutableDictionary *) dictpatameters resultBlock:(void (^)(ServiceResultInfo *statusInfo, UserBaseModel *userInfo))completions {
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_UPDATEUSERINFO
                                    urlParameters:dictpatameters.copy
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     if (resultStatusInfo.finishStatus) {
                                         UserBaseModel *user = [UserBaseModel jsonDataWithModel:responsedata];
                                         [CoreStore sharedStore].userBaseModel = user;
                                         completions(resultStatusInfo, user);
                                     } else {
                                         completions(resultStatusInfo, nil);
                                     }
                                 }];
}

- (void)uploadMyIconBadgeImg:(UIImage *) iconImg resultBlock:(void (^)(BOOL finish, NSString *iconURL))completions {
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_IMAGE_UPLOAD
                                      urlResource:URL_POST_UPDATEUSERINFO
                                    urlParameters:nil
                                          imgName:@"avatar"
                                      uploadImage:iconImg
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     if (resultStatusInfo.finishStatus) {
                                         UserBaseModel *user = [UserBaseModel jsonDataWithModel:responsedata];
                                         [CoreStore sharedStore].userBaseModel = user;
                                         completions(resultStatusInfo.finishStatus, user.UserIconURL);
                                     } else {
                                         completions(resultStatusInfo.finishStatus, nil);
                                     }
                                 }];
}

/**
 getCurrentTeamContacts
 @param index                 pageInfoModel
 */
- (void)getCurrentTeamContactsWithPageInfo:(PageInfoModel *)index resultBlock:(void (^)(ServiceResultInfo *statusInfo, PageInfoModel *pageInfo, NSMutableArray *contacts))completions {
    
    NSDictionary * dicParameter = [self buildingPageIndex:index];
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_GET
                                      urlResource:URL_GET_CONTACTS
                                    urlParameters:dicParameter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     if (resultStatusInfo.finishStatus) {
                                         NSMutableArray *data = [UserBaseModel jsonDataWithModel:responsedata[@"contacts"]];
                                         PageInfoModel *pageInfo = [PageInfoModel jsonDataWithModel:responsedata[@"page"]];
                                         
                                         completions(resultStatusInfo, pageInfo, data);
                                     }else{
                                         
                                         completions(resultStatusInfo, nil, nil);
                                     }
    }];
}

///**
// join the team (Maybe appication version2.0 will use this API)
// @param team_id               team_id
// @param string                ???team_id???
// */
//- (void)joinTheTeamWithTeamID:(NSString *)team_id string:(NSString *)string resultBlock:(void (^)(ServiceResultInfo * resultStatusInfo))completions{
//    
//}

#pragma mark - Public Method
- (void)logoutCleanupUserData
{
    [CoreStore sharedStore].isLogin = NO;
    //置空accessToken
    [CoreStore sharedStore].patrolAccessToken = nil;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
@end
