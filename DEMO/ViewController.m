//
//  ViewController.m
//  DEMO
//
//  Created by 郭鹏 on 2021/11/28.
//  Copyright © 2021 郭鹏. All rights reserved.
//

#import "ViewController.h"
#import "GPChainedCalculator.h"
#import "GPVideoCamera.h"
#import "GPOpenGLView.h"


@interface ViewController ()
@property (nonatomic, strong) GPVideoCamera *camera;
@property (nonatomic, weak) GPOpenGLView *openGLView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        GPChainedCalculator *mgr = [[GPChainedCalculator alloc] init];
    
        mgr.add(5).add(5).add(7).add(8);

}

- (void)videoCamera{
        // 创建摄像头
        GPVideoCamera *camera = [GPVideoCamera cameraWithSessionPreset:AVCaptureSessionPreset1280x720 postion:AVCaptureDevicePositionFront];
        _camera = camera;
        
        __weak typeof(self) weakSelf = self;
        camera.captureVideoSampleBufferBlcok = ^(CMSampleBufferRef sampleBuffer){
            [weakSelf processSampleBuffer:sampleBuffer];
        };        
        // 开始捕获数据
        [camera startCapture];
    
}

// 处理图片
- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    // 把图片数据展示屏幕
    // GPUImage -> OpenGL
    // 展示到XMGOpenGLView
    [self.openGLView displayWithSampleBuffer:sampleBuffer];
}

- (GPOpenGLView *)openGLView
{
    if (_openGLView == nil) {
        GPOpenGLView *openGLView = [[GPOpenGLView alloc] initWithFrame:self.view.bounds];
        _openGLView = openGLView;
        [self.view addSubview:openGLView];
    }
    return _openGLView;
}
@end
