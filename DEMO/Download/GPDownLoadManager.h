//
//  GPDownLoaderFileTool.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPDownLoader.h"

@interface GPDownLoadManager : NSObject

// 单例
+ (instancetype)shareInstance;

// 根据URL下载资源
- (GPDownLoader *)downLoadWithURL: (NSURL *)url;

// 获取url对应的downLoader
- (GPDownLoader *)getDownLoaderWithURL: (NSURL *)url;

// 根据URL下载资源
// 监听下载信息, 成功, 失败回调
- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (DownLoadInfoType)downLoadBlock success: (DownLoadSuccessType)successBlock failed: (DownLoadFailType)failBlock;

// 根据URL暂停资源
- (void)pauseWithURL: (NSURL *)url;

// 根据URL取消资源
- (void)cancelWithURL: (NSURL *)url;
- (void)cancelAndClearWithURL: (NSURL *)url;

// 暂停所有
- (void)pauseAll;

// 恢复所有
- (void)resumeAll;


@end
