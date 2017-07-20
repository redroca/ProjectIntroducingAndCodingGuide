//
//  AppConstants.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//
#define     kAMapKitKey                 @"81e93456392725feb477251d821008e7"

#define     kGrowingIOID                @"835537e289c975db"

#define     CUTDOWNOSSIMAGEURL(h, w)    [NSString stringWithFormat:@"?x-oss-process=image/resize,m_fill,h_%d,w_%d", h, w]

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

