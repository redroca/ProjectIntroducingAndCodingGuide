//
//  AgoraRtcEngineWrapper.h
//  Patrol
//
//  Created by hades on 2017/5/22.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@protocol AgoraRtcEngineWrapperDelegate <NSObject>

@optional
- (void)MCRtcEngineConnectionDidInterrupted;

- (void)MCRtcEngineConnectionDidLost;

- (void)MCRtcEngineDidOccurError;

- (void)MCRtcEngineFirstLocalVideo;

- (void)MCRtcEngineFirstRemoteVideoDecodedOfUid:(NSInteger)uid;

- (void)MCRtcEngineDidOffline;
@end

@interface AgoraRtcEngineWrapper : NSObject
+ (instancetype)sharedInstance;


/**
 init AgoraKit and set delegate

 @param delegate AgoraRtcEngineWrapperDelegate delegate
 */
- (void)startAgoraKitWithDelegate:(id <AgoraRtcEngineWrapperDelegate>)delegate;


/**
 setup video and setting
 */
- (void)setupVideo;


/**
 set local view and show

 @param localView show the local video from camara
 */
- (void)setupLocalVideo:(UIView *)localView;


/**
 set remote view and show

 @param remoteView show remote video from other user
 */
- (void)setupRemoteVideo:(UIView *)remoteView withUid:(NSInteger)uid;

/**
 When other not enter the video room, show preview
 */
- (void)startPreview;

- (void)stopPreview;

/**
 join channel room to video

 @param roomName the room name is callee's id
 @return BOOL if YES join room success
 */
- (BOOL)joinChannelRoom:(NSString *)roomName;

/**
 leave channel when stop video
 */
- (void)leaveChannel;

- (void)startCallWithCallee:(NSString *)callee callType:(NSInteger)type;

- (void)acceptCallWithCaller:(NSString *)caller;

- (void)rejectCallWithCaller:(NSString *)caller;

- (void)endCallWithUserID:(NSString *)user;

- (void)busyCallWithCaller:(NSString *)caller;

/**************Camera Control*****************/
- (void)switchCamera;
@end
