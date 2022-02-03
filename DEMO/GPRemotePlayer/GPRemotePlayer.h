//
//  GPTabBarController.h
//  DEMO
//
//  Created by 郭鹏 on 2021/12/5.
//  Copyright © 2021 郭鹏. All rights reserved.


#import <Foundation/Foundation.h>

#define kRemotePlayerURLOrStateChangeNotification @"remotePlayerURLOrStateChangeNotification"

/**
 * 播放器的状态
 * 因为UI界面需要加载状态显示, 所以需要提供加载状态
 - GPRemotePlayerStateUnknown: 未知(比如都没有开始播放音乐)
 - GPRemotePlayerStateLoading: 正在加载()
 - GPRemotePlayerStatePlaying: 正在播放
 - GPRemotePlayerStateStopped: 停止
 - GPRemotePlayerStatePause:   暂停
 - GPRemotePlayerStateFailed:  失败(比如没有网络缓存失败, 地址找不到)
 */
typedef NS_ENUM(NSInteger, GPRemotePlayerState) {
    GPRemotePlayerStateUnknown = 0,
    GPRemotePlayerStateLoading   = 1,
    GPRemotePlayerStatePlaying   = 2,
    GPRemotePlayerStateStopped   = 3,
    GPRemotePlayerStatePause     = 4,
    GPRemotePlayerStateFailed    = 5
};

@interface GPRemotePlayer : NSObject

+ (instancetype)shareInstance;


/**
 根据URL地址进行播放音频
 @param url url
 */
- (void)playWithURL: (NSURL *)url;

/** 暂停当前音频 */
- (void)pause;

/** 继续播放 */
- (void)resume;

/** 停止播放 */
- (void)stop;

/**
 快速播放到某个时间点
 @param time 时间
 */
- (void)seekWithTime: (NSTimeInterval)time;

/** 速率 */
@property (nonatomic, assign) float rate;

/** 声音 */
@property (nonatomic, assign) float volume;

/** 静音 */
@property (nonatomic, assign) BOOL mute;

/** 根据进度播放 */
@property (nonatomic, assign) float progress;

/** 音频总时长 */
@property (nonatomic, assign, readonly) double duration;

/** 音频当前播放时长 */
@property (nonatomic, assign, readonly) double currentTime;

/** 音频当前播放URL */
@property (nonatomic, strong, readonly) NSURL *url;

/** 音频当前加载进度 */
@property (nonatomic, assign, readonly) float loadProgress;

/** 音频当前播放状态 */
@property (nonatomic, assign, readonly) GPRemotePlayerState state;

/** 监听音频播放状态 */
@property (nonatomic, copy) void(^stateChange)(GPRemotePlayerState state);

/** 监听音频播放完成 */
@property (nonatomic, copy) void(^playEndBlock)();

@end
