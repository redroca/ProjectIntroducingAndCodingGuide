//
//  RecoveryPassWordAPIRESTfulService.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/9.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "RESTfulBaseService.h"

@interface RecoveryPassWordAPIRESTfulService : RESTfulBaseService

+ (instancetype)sharedSingleton;

///send snd_code to user  (recovery PassWord step : 1)
- (void)sendSndCodeToCurrentUserWithPhoneNumberString:(NSString *)phoneNumStr resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///verify the snd_code    (recovery PassWord step : 2)
- (void)verifyTheSndCode:(NSString *)code resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///rest password          (recovery PassWord step : 3)
- (void)resetPassword:(NSString *)password passwordConfirm:(NSString *)password_confirm resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;

///update password (now user is logged in,change password)
- (void)updatePassword:(NSString *)currentPassword newPassword:(NSString *)password resultBlock:(void (^)(ServiceResultInfo *statusInfo))completions;


@end
