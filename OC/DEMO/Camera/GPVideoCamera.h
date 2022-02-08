//
//  SceneDelegate.h
//  DEMO
//
//  Created by 郭鹏 on 2021/11/28.
//  Copyright © 2021 郭鹏. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface GPVideoCamera : NSObject
+ (instancetype)cameraWithSessionPreset:(NSString *)sessionPreset postion:(AVCaptureDevicePosition)postion;

// 控制帧率 default:15
@property (nonatomic, assign) int frameRaw;

@property (nonatomic, assign) BOOL isVideoDataRGB;

@property (nonatomic, assign) AVCaptureVideoOrientation videoOrientation;

@property (nonatomic, assign) BOOL videoMirrored;

@property (nonatomic, assign) BOOL isCaputureAudioData;

@property (nonatomic, strong) void(^captureVideoSampleBufferBlcok)(CMSampleBufferRef sampleBuffer);

@property (nonatomic, strong) void(^captureAudioSampleBufferBlcok)(CMSampleBufferRef sampleBuffer);

- (void)startCapture;

@end
