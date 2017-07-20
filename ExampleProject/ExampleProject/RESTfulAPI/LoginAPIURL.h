//
//  LoginAPIURL.h
//  Patrol
//
//  Created by 李林峰 on 2017/5/5.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "BaseAPIURL.h"

///AccessToken
#define URL_POST_GETACCESSTOKEN     @"https://api.xunbaox.com/oauth/token"
//#define URL_POST_GETACCESSTOKEN     @"http://192.168.8.169:3000/oauth/token"

///get userInfo
#define URL_GET_USERINFO            [NSString stringWithFormat:@"%@/users/me%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///user signout
#define URL_DELETE_SIGNOUT          [NSString stringWithFormat:@"%@/users/sign_out%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///update userInfo
#define URL_POST_UPDATEUSERINFO     [NSString stringWithFormat:@"%@/users%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]
///get currentTeamContacts
#define URL_GET_CONTACTS            [NSString stringWithFormat:@"%@/users/contacts%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN]

///选择进入的团队[下一个版本考虑]
#define URL_GET_TEAM(i)             [NSString stringWithFormat:@"%@/users/teams%@&%@", RESTFUL_BASE_HOST,RESTFUL_SUFFIX_TOKEN,i]

