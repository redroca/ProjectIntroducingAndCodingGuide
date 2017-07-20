//
//  AliyunOSSWrapper.h
//  Patrol
//
//  Created by hades on 2017/5/18.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliyunOSSWrapper : NSObject
+ (instancetype)sharedInstance;

- (void)setupEnvironment;

// 异步上传
- (void)uploadObjectAsyncWithPath:(NSString *)filePath
                       completion:(void (^)(NSString *fileName, BOOL success))completion;

// 异步下载
//- (void)downloadObjectAsyncWithFileName:(NSString *)fileName;
@end
