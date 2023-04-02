//
//  SceneDelegate.h
//  DEMO
//
//  Created by 郭鹏 on 2021/11/28.
//  Copyright © 2021 郭鹏. All rights reserved.
//


#import "GPVideoCamera.h"

@interface GPVideoCamera ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, weak) AVCaptureVideoDataOutput *videoOutput;
@end
   
@implementation GPVideoCamera

+ (instancetype)cameraWithSessionPreset:(NSString *)sessionPreset postion:(AVCaptureDevicePosition)postion
{
    GPVideoCamera *camera = [[self alloc] init];
    
    // 创建会话
    [camera setupSession:sessionPreset];
    
    // 添加视频
    [camera setupVideo:postion];
    
   
    return camera;
}
- (void)setIsCaputureAudioData:(BOOL)isCaputureAudioData
{
    _isCaputureAudioData = isCaputureAudioData;
    
    if (_isCaputureAudioData == YES) {
        // 添加音频
        [self setupAudio];
    }
}

- (instancetype)init
{
    if (self = [super init]) {
        _videoMirrored = YES;
        _videoOrientation = AVCaptureVideoOrientationPortrait;
        _frameRaw = 15;
        _isVideoDataRGB = NO;
    }
    return self;
}


// 捕获音频
- (void)setupAudio
{
    // 获取音频设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    // 转换音频输入对象
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:nil];
    
    // 创建音频输出对象
    // 音频格式PCM
    // 对应音频输出,音频输入必须对应音频输出
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    
    if ([_session canAddInput:audioInput]) {
        [_session addInput:audioInput];
    }
    
    if ([_session canAddOutput:audioOutput]) {
        [_session addOutput:audioOutput];
    }
    dispatch_queue_t audioQueue = dispatch_queue_create("audioQueue", DISPATCH_QUEUE_SERIAL);
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    
}

- (void)setupVideo:(AVCaptureDevicePosition)postion
{
    // 获取前置摄像头照相机
    AVCaptureDevice *videoDevice = [self videoDeviceWithPostion:postion];
    
    // 捕获视频 => 视频输入 视频输出
    // 创建视频输入
    // 指定一个设备,创建对应设备的输入对象
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    
    // 创建视频输出对象
    AVCaptureVideoDataOutput *videoOutput = [self setupVideoOutput];
    _videoOutput = videoOutput;
    
    // 给会话添加视频输入
    if ([_session canAddInput:videoInput]) {
        [_session addInput:videoInput];
    }
    
    // 给会话添加视频输出
    if ([_session canAddOutput:videoOutput]) {
        [_session addOutput:videoOutput];
    }
    // 获取连接
    // 只要给会话添加输入和输出就会自动创建连接
    AVCaptureConnection *videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    // 设置竖屏
    videoConnection.videoOrientation = _videoOrientation;
    videoConnection.automaticallyAdjustsVideoMirroring = NO;
    videoConnection.videoMirrored = _videoMirrored;
    
}

- (AVCaptureVideoDataOutput *)setupVideoOutput
{
    // 创建视频输出
    // 获取采集视频数据,并不是写成文件
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    // 15 : 每秒多少帧
    // minFrameDuration : 最小帧率
    videoOutput.minFrameDuration = CMTimeMake(1, _frameRaw);
    
    // videoSettings : 设置视频格式
    // YUV 和 RGB
    // 在苹果开发中,只要渲染,只支持RGB
    // YUV , 流媒体的时候,通常使用YUV
    // kCVPixelFormatType_420YpCbCr8BiPlanarFullRange(YUV)
    // kCVPixelFormatType_32BGRA(RGB)
    
    NSString *dataFmt = nil;
    
    if (_isVideoDataRGB) {
        dataFmt = @(kCVPixelFormatType_32BGRA);
    } else {
        dataFmt = @(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange);
    }
    
    videoOutput.videoSettings = @{(NSString *)kCVPixelBufferPixelFormatTypeKey:dataFmt};
    
    // alwaysDiscardsLateVideoFrames:延迟的时候,是否丢帧
    videoOutput.alwaysDiscardsLateVideoFrames = YES;
    
    // 通过代理获取采集数据
    // queue:建议一定要使用同步队列,因为帧要有顺序
    // 创建同步队列
    dispatch_queue_t videoQueue = dispatch_queue_create("videoQueue", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
    
    return videoOutput;
}

// 指定一个摄像头方向,获取对应摄像设备
- (AVCaptureDevice *)videoDeviceWithPostion:(AVCaptureDevicePosition)positon
{
    // defaultDeviceWithMediaType获取后置摄像头
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in videoDevices) {
        if (device.position == positon) {
            return device;
        }
    }
    
    return nil;
}


- (void)setupSession:(NSString *)sessionPreset
{
    // 创建捕获会话 AVCaptureSession
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    _session = session;
    if (sessionPreset.length == 0) {
        sessionPreset = AVCaptureSessionPresetHigh;
    }
    session.sessionPreset = sessionPreset;
}

- (void)startCapture
{
    [_session startRunning];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (_videoOutput == captureOutput) { // 视频
        if (_captureVideoSampleBufferBlcok) {
            _captureVideoSampleBufferBlcok(sampleBuffer);
        }
        
    } else { // 音频
        if (_captureAudioSampleBufferBlcok) {
            _captureAudioSampleBufferBlcok(sampleBuffer);
        }
    }
    
   
    
}

@end
