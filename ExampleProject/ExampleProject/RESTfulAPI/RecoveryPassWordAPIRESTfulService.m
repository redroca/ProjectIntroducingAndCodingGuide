//
//  RecoveryPassWordAPIRESTfulService.m
//  Patrol
//
//  Created by 李林峰 on 2017/5/9.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "RecoveryPassWordAPIRESTfulService.h"
#import "RecoveryPasswordAPIURL.h"

static RecoveryPassWordAPIRESTfulService * _sharedSingleton = nil;
static BOOL isFirstAccess = YES;

@implementation RecoveryPassWordAPIRESTfulService
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

///send snd_code to user  (recovery PassWord step : 1)
- (void)sendSndCodeToCurrentUserWithPhoneNumberString:(NSString *)phoneNumStr resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{

//    signature
//    签名算法：MD5("MG#{params[:mobile]}#{params[:nonce]}#{app_key}#{app_secret}")
//    创建一个UUID随机字符串
    NSString * nonceString = [NSString createUUID];
    NSString * signatureString = [NSString stringWithFormat:@"MG%@%@%@%@",phoneNumStr,nonceString,CLIENT_ID,CLIENT_SECRET];
    NSString * signatureMD5String = [signatureString MD5Hash];
//    NSLog(@"signatureString = %@,MD5=%@",signatureString,signatureMD5String);
    
    NSDictionary * dicParamter = @{@"signature" : signatureMD5String,
                                      @"mobile" : phoneNumStr,
                                       @"nonce" : nonceString,};
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_SEND_SNDCODE
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         //缓存accessToken
                                        [CoreStore sharedStore].patrolAccessToken = responsedata[@"access_token"];
                                     }
                                         completions(resultStatusInfo);
    }];
}

///verify the snd_code    (recovery PassWord step : 2)
- (void)verifyTheSndCode:(NSString *)code resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{
    
    NSString * accessToken = [CoreStore sharedStore].patrolAccessToken;
    NSDictionary * dicParamter = @{@"access_token" : accessToken,
                                           @"code" : code,};

    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_VERIFY_SNDCODE
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                    
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         //缓存accessToken
                                         [CoreStore sharedStore].patrolAccessToken = responsedata[@"access_token"];
                                     }
                                         completions(resultStatusInfo);
    }];
}
///rest password          (recovery PassWord step : 3)
- (void)resetPassword:(NSString *)password passwordConfirm:(NSString *)password_confirm resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{
    
    NSString * accessToken = [CoreStore sharedStore].patrolAccessToken;
    NSDictionary * dicParamter = @{@"access_token" : accessToken,
                                       @"password" : password,
                               @"password_confirm" : password_confirm,};
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_RESET_PASSWORD
                                    urlParameters:dicParamter
                                 actionCompletion:^(id responsedata, ServiceResultInfo *resultStatusInfo) {
                                     
                                     if (resultStatusInfo.finishStatus) {
                                         
                                         completions(resultStatusInfo);
                                     }else{
                                         
                                         completions(resultStatusInfo);
                                     }
                                 }];
}

///update password (now user is logged in,change password)
- (void)updatePassword:(NSString *)currentPassword newPassword:(NSString *)password resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions{
    
    NSDictionary * dicParamter = @{@"current_password" : currentPassword,
                                           @"password" : password,};
    
    [[RESTfulAPIWrapper sharedInstance] operation:OPERATION_POST
                                      urlResource:URL_POST_UPDATE_PASSWORD
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
