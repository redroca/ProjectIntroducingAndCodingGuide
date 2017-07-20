//
//  AgoraRtcEngineWrapper.m
//  Patrol
//
//  Created by hades on 2017/5/22.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "AgoraRtcEngineWrapper.h"
#import "CallsAPIRESTfulService.h"

static NSString *AppID = @"4be2659f4604406392bf5eca1157c761";

static AgoraRtcEngineWrapper *SINGLETON = nil;

@interface AgoraRtcEngineWrapper () <AgoraRtcEngineDelegate>
@property(nonatomic, strong) AgoraRtcEngineKit *agoraKit;

@property(nonatomic, weak) id <AgoraRtcEngineWrapperDelegate> delegate;
@end

@implementation AgoraRtcEngineWrapper
#pragma mark - Life Cycle

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[AgoraRtcEngineWrapper alloc] init];
}

- (id)mutableCopy
{
    return [[AgoraRtcEngineWrapper alloc] init];
}

- (id)init
{
    if(SINGLETON){
        return SINGLETON;
    }
    self = [super init];
    return self;
}

#pragma mark - Public Method
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[super allocWithZone:NULL] init];
//        SINGLETON.delegate = self;
    });
    return SINGLETON;
}

#pragma mark - 
- (void)startAgoraKitWithDelegate:(id <AgoraRtcEngineWrapperDelegate>)delegate {
    self.delegate = delegate;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:AppID delegate:self];
}

- (void)setupVideo {
    [self.agoraKit enableVideo];
    [self.agoraKit setVideoProfile:AgoraRtc_VideoProfile_720P swapWidthAndHeight:false];
}

- (void)setupLocalVideo:(UIView *)localView {
    if (localView) {
        AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
        canvas.uid = 0;
        canvas.view = localView;
        canvas.renderMode = AgoraRtc_Render_Hidden;
        [self.agoraKit setupLocalVideo:canvas];
    } else {
        [self.agoraKit setupLocalVideo:nil];
    }
}

- (void)setupRemoteVideo:(UIView *)remoteView withUid:(NSInteger)uid {
    if (remoteView) {
        AgoraRtcVideoCanvas *canvas = [[AgoraRtcVideoCanvas alloc] init];
        canvas.uid = uid;
        canvas.view = remoteView;
        canvas.renderMode = AgoraRtc_Render_Hidden;
        [self.agoraKit setupRemoteVideo:canvas];
    } else {
        [self.agoraKit setupRemoteVideo:nil];
    }
}

- (void)startPreview {
    [self.agoraKit startPreview];
}

- (void)stopPreview {
    [self.agoraKit stopPreview];
}

- (BOOL)joinChannelRoom:(NSString *)roomName {
    int code = [self.agoraKit joinChannelByKey:nil
                                   channelName:roomName
                                          info:nil
                                           uid:0
                                   joinSuccess:nil];
    if (code == 0) {
        return YES;
    } else {
        NSLog(@"join room failed %d", code);
        return NO;
    }
}

- (void)leaveChannel {
    [self.agoraKit setupLocalVideo:nil];
    [self.agoraKit leaveChannel:nil];
}

#pragma mark - Video Handle
- (void)startCallWithCallee:(NSString *)callee callType:(NSInteger)type
{
    [[CallsAPIRESTfulService sharedSingleton] startCallWithCalleeID:callee callType:type resultBlock:^(ServiceResultInfo *statusInfo) {
        
    }];
}

- (void)acceptCallWithCaller:(NSString *)caller
{
    [[CallsAPIRESTfulService sharedSingleton] acceptCallWithCallerID:caller resultBlock:^(ServiceResultInfo *statusInfo) {
        
    }];
}

- (void)rejectCallWithCaller:(NSString *)caller
{
    [[CallsAPIRESTfulService sharedSingleton] rejectCallWithCallerID:caller resultBlock:^(ServiceResultInfo *statusInfo) {
        
    }];
}

- (void)endCallWithUserID:(NSString *)user
{
    [[CallsAPIRESTfulService sharedSingleton] endCallWithUserID:user resultBlock:^(ServiceResultInfo *statusInfo) {
        
    }];
}

- (void)busyCallWithCaller:(NSString *)caller
{
    [[CallsAPIRESTfulService sharedSingleton] busyCallWithCallerID:caller restultBlock:^(ServiceResultInfo *statusInfo) {
        
    }];
}

- (void)switchCamera
{
    [self.agoraKit switchCamera];
}

#pragma mark - AgoraRtcEngineDelegate
- (void)rtcEngineConnectionDidInterrupted:(AgoraRtcEngineKit *)engine
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCRtcEngineConnectionDidInterrupted)]) {
        [self.delegate MCRtcEngineConnectionDidInterrupted];
    }
}

- (void)rtcEngineConnectionDidLost:(AgoraRtcEngineKit *)engine
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCRtcEngineConnectionDidLost)]) {
        [self.delegate MCRtcEngineConnectionDidLost];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraRtcErrorCode)errorCode
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCRtcEngineDidOccurError)]) {
        [self.delegate MCRtcEngineDidOccurError];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size:(CGSize)size elapsed:(NSInteger)elapsed
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCRtcEngineFirstRemoteVideoDecodedOfUid:)]) {
        [self.delegate MCRtcEngineFirstRemoteVideoDecodedOfUid:uid];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCRtcEngineFirstLocalVideo)]) {
        [self.delegate MCRtcEngineFirstLocalVideo];
    }
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraRtcUserOfflineReason)reason
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MCRtcEngineDidOffline)]) {
        [self.delegate MCRtcEngineDidOffline];
    }
}


@end
