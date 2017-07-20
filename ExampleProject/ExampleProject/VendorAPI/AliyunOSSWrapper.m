//
//  AliyunOSSWrapper.m
//  Patrol
//
//  Created by hades on 2017/5/18.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "AliyunOSSWrapper.h"
#import <AliyunOSSiOS/OSSService.h>

NSString * const AccessKey = @"LTAIwuK2YlczTRWL";
NSString * const SecretKey = @"0kjIOSeiYUK1u50IJXvmaflDRnwt7x";
NSString * const endPoint = @"http://oss-cn-shanghai.aliyuncs.com";
NSString * const multipartUploadKey = @"multipartUploadObject";
NSString * const oss_bucket = @"xunbao";

OSSClient * client;
static dispatch_queue_t ossQueue;

@interface AliyunOSSWrapper ()

@end

@implementation AliyunOSSWrapper
+ (instancetype)sharedInstance{
    static AliyunOSSWrapper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AliyunOSSWrapper alloc] init];
    });
    return instance;
}

- (void)setupEnvironment {
    // 打开调试log
    [OSSLog enableLog];
    
    // 在本地生成一些文件用来演示
//    [self initLocalFile];
    
    // 初始化sdk
    [self initOSSClient];
}

- (void)initOSSClient {
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey secretKey:SecretKey];
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
//    // 自实现签名，可以用本地签名也可以远程加签
//    id<OSSCredentialProvider> credential1 = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
//        NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:SecretKey];
//        if (signature != nil) {
//            *error = nil;
//        } else {
//            // construct error object
//            *error = [NSError errorWithDomain:@"<your error domain>" code:OSSClientErrorCodeSignFailed userInfo:nil];
//            return nil;
//        }
//        return [NSString stringWithFormat:@"OSS %@:%@", @"<your access key>", signature];
//    }];
}

// 异步上传
- (void)uploadObjectAsyncWithPath:(NSString *)filePath completion:(void (^)(NSString *fileName, BOOL success))completion {
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    // required fields
    put.bucketName = oss_bucket;
    put.objectKey = [filePath lastPathComponent];
    
    
    
    put.uploadingFileURL = [NSURL fileURLWithPath:filePath];
    
    // optional fields
//    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
//    };
    
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
            completion(put.objectKey, YES);
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
            completion(nil, NO);
        }
        return nil;
    }];
}

// 异步下载
- (void)downloadObjectAsyncWithFileName:(NSString *)fileName savePath:(NSString *)savePath completion:(void (^)(BOOL success))completion {
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    // required
    request.bucketName = oss_bucket;
    request.objectKey = fileName;
    
    //optional
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    };
    OSSTask * getTask = [client getObject:request];
    
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
//            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            completion(YES);
        } else {
            NSLog(@"download object failed, error: %@" ,task.error);
            completion(NO);
        }
        return nil;
    }];
}

@end
