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
#import "GPTes.h"



@interface ViewController ()
@property (nonatomic, strong) GPVideoCamera *camera;
@property (nonatomic, weak) GPOpenGLView *openGLView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        GPChainedCalculator *mgr = [[GPChainedCalculator alloc] init];
    
        mgr.add(5).add(5).add(7).add(8);
    
    CGRect r = CGRectMake(1, 1, 1, 1);
    
    CGRect rr = r;
    
    r.origin.x = 2;
    
    NSLog(@"r:%@-----rr:%@",NSStringFromCGRect(r),NSStringFromCGRect(rr));

    
    GPTes *t = [[GPTes alloc]init];
    t.testInt = 1;
    
    GPTes *tt = t;
    
    tt.testInt = 2;
    
    NSLog(@"tt:%ld-----t:%ld",tt.testInt,t.testInt);
    
    
    
    NSInteger i = 1;
    NSInteger ii = i;
    i++;
    NSLog(@"1:%ld--22:%ld",i,ii);
    
    
    NSMutableString *s = [[NSMutableString alloc]initWithString:@"aaa"];
    NSMutableString *ss = s;
    [s appendString:@"222"];
    
    NSLog(@"前===s:%@---ss:%@",s,ss);
    ss = [[NSMutableString alloc]initWithString:@"fghjkl"];
    NSLog(@"后===s:%@---ss:%@",s,ss);

    
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:@"1"];
//
//    NSMutableArray *tempArray = [NSMutableArray array];
//
//    [tempArray addObject:array];
//
//    NSMutableArray *aaa = [tempArray mutableCopy];
//
//    NSMutableArray *bbb = aaa.firstObject;
//
//    [bbb removeAllObjects];
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//
//    NSMutableArray *array = [NSMutableArray array];
//
//    [array addObject:@"a"];
//
//
//    dic[@"1"] = array;
    
//    NSMutableDictionary *copyDic = [dic mutableCopy];
    
//    NSMutableArray *copyArray0 = copyDic[@"1"];
    
    
//    [copyArray0 removeAllObjects];
    
//    NSMutableArray *copyArray = [dic[@"1"] mutableCopy];
//
//    [copyArray removeAllObjects];
//
//
//
//
//
//    NSLog(@"zouni");

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
