//
//  RecoveryPasswordAPIURL.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/9.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//


#import "BaseAPIURL.h"

///send snd_code to user  (recovery PassWord step : 1)
#define URL_POST_SEND_SNDCODE           [NSString stringWithFormat:@"%@/passwords/snd_code%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///verify the snd_code    (recovery PassWord step : 2)
#define URL_POST_VERIFY_SNDCODE         [NSString stringWithFormat:@"%@/passwords/verify_code%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///rest password          (recovery PassWord step : 3)
#define URL_POST_RESET_PASSWORD         [NSString stringWithFormat:@"%@/passwords/reset%@",RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///update password (now user is logged in,change password)
#define URL_POST_UPDATE_PASSWORD        [NSString stringWithFormat:@"%@/passwords/update%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

