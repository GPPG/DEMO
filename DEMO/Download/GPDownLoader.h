//
//  GPDownLoaderFileTool.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDownLoadURLOrStateChangeNotification @"downLoadURLOrStateChangeNotification"

typedef enum : NSUInteger {
    GPDownLoaderStateUnKnown,
    /** 下载暂停 */
    GPDownLoaderStatePause,
    /** 正在下载 */
    GPDownLoaderStateDowning,
    /** 已经下载 */
    GPDownLoaderStateSuccess,
    /** 下载失败 */
    GPDownLoaderStateFailed
} GPDownLoaderState;


typedef void(^DownLoadInfoType)(long long fileSize);
typedef void(^DownLoadSuccessType)(NSString *cacheFilePath);
typedef void(^DownLoadFailType)();

@interface GPDownLoader : NSObject

// 如果当前已经下载, 继续下载, 如果没有下载, 从头开始下载
- (void)downLoadWithURL: (NSURL *)url;

+ (NSString *)downLoadedFileWithURL: (NSURL *)url;
+ (long long)tmpCacheSizeWithURL: (NSURL *)url;
+ (void)clearCacheWithURL: (NSURL *)url;


- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (DownLoadInfoType)downLoadBlock success: (DownLoadSuccessType)successBlock failed: (DownLoadFailType)failBlock;

// 恢复下载
- (void)resume;

// 暂停, 暂停任务, 可以恢复, 缓存没有删除
- (void)pause;

// 取消
- (void)cancel;

// 缓存删除
- (void)cancelAndClearCache;

// 状态
@property (nonatomic, assign, readonly) GPDownLoaderState state;

// 进度
@property (nonatomic, assign) float progress;

// 下载进度
@property (nonatomic, copy) void(^downLoadProgress)(float progress);

// 文件下载信息 (下载的大小)
@property (nonatomic, copy) DownLoadInfoType downLoadInfo;

// 状态的改变 ()
@property (nonatomic, copy) void(^downLoadStateChange)(GPDownLoaderState state);

// 下载成功 (成功路径)
@property (nonatomic, copy) DownLoadSuccessType downLoadSuccess;

// 失败 (错误信息)
@property (nonatomic, copy) DownLoadFailType downLoadError;


@end
