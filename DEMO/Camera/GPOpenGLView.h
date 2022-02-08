//
//  SceneDelegate.h
//  DEMO
//
//  Created by 郭鹏 on 2021/11/28.
//  Copyright © 2021 郭鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface GPOpenGLView : UIView
- (void)displayWithSampleBuffer:(CMSampleBufferRef)sampleBuffer;
@end
