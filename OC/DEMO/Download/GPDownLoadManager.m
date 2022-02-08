//
//  GPDownLoaderFileTool.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPDownLoadManager.h"
#import "NSString+GPString.h"

@interface GPDownLoadManager()

@property (nonatomic, strong) NSMutableDictionary <NSString *, GPDownLoader *>*downLoadInfo;

@end


@implementation GPDownLoadManager

// 绝对的单例: 无论通过什么样的方式, 创建, 都是一个对象
// 非绝对的单例
static GPDownLoadManager *_shareInstance;
+ (instancetype)shareInstance {
    
    if (!_shareInstance) {
        _shareInstance = [[GPDownLoadManager alloc] init];
    }
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!_shareInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}


- (NSMutableDictionary *)downLoadInfo {
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}

- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (DownLoadInfoType)downLoadBlock success: (DownLoadSuccessType)successBlock failed: (DownLoadFailType)failBlock {
    
    NSString *md5 = [url.absoluteString md5Str];
    
    GPDownLoader *downLoader = self.downLoadInfo[md5];
    if (downLoader) {
        [downLoader resume];
        return ;
    }
    downLoader = [[GPDownLoader alloc] init];
    [self.downLoadInfo setValue:downLoader forKey:md5];
    
    __weak typeof(self) weakSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:downLoadBlock success:^(NSString *cacheFilePath) {
        [weakSelf.downLoadInfo removeObjectForKey:md5];
        if(successBlock) {
            successBlock(cacheFilePath);
        }
    } failed:^{
        [weakSelf.downLoadInfo removeObjectForKey:md5];
        if (failBlock) {
            failBlock();
        }
    }];
    
    return ;

    
    
}

- (GPDownLoader *)downLoadWithURL: (NSURL *)url
{
    
    // 文件名称  aaa/a.x  bb/a.x
    
    NSString *md5 = [url.absoluteString md5Str];
    
    GPDownLoader *downLoader = self.downLoadInfo[md5];
    if (downLoader) {
        [downLoader resume];
        return downLoader;
    }
    downLoader = [[GPDownLoader alloc] init];
    [self.downLoadInfo setValue:downLoader forKey:md5];
    
    __weak typeof(self) weakSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:nil success:^(NSString *cacheFilePath) {
        [weakSelf.downLoadInfo removeObjectForKey:md5];
    } failed:^{
        [weakSelf.downLoadInfo removeObjectForKey:md5];
    }];
    
    return downLoader;
    
}

- (GPDownLoader *)getDownLoaderWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    GPDownLoader *downLoader = self.downLoadInfo[md5];
    return downLoader;
}

- (void)pauseWithURL: (NSURL *)url {
    
    NSString *md5 = [url.absoluteString md5Str];
    GPDownLoader *downLoader = self.downLoadInfo[md5];
    [downLoader pause];
    
}

- (void)cancelWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    GPDownLoader *downLoader = self.downLoadInfo[md5];
    [downLoader cancel];
}
- (void)cancelAndClearWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    GPDownLoader *downLoader = self.downLoadInfo[md5];
    [downLoader cancelAndClearCache];
}

- (void)pauseAll {
    
    [[self.downLoadInfo allValues] makeObjectsPerformSelector:@selector(pause)];

}



@end
