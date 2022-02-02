//
//  GPDownLoaderFileTool.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPDownLoaderFileTool.h"

@implementation GPDownLoaderFileTool
+ (BOOL)isFileExists: (NSString *)path {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}


+ (long long)fileSizeWithPath: (NSString *)path {
    
    if (![self isFileExists:path]) {
        return 0;
    }
    
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    
    long long size = [fileInfo[NSFileSize] longLongValue];
    
    return size;
    
    
}

+ (void)moveFile:(NSString *)fromPath toPath: (NSString *)toPath {
    
    if (![self isFileExists:fromPath]) {
        return;
    }
    
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
    
    
}

+ (void)removeFileAtPath: (NSString *)path {
    
    if (![self isFileExists:path]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
}
@end
