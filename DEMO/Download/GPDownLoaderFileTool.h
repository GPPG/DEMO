//
//  GPDownLoaderFileTool.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPDownLoaderFileTool : NSObject

+ (BOOL)isFileExists: (NSString *)path;

+ (long long)fileSizeWithPath: (NSString *)path;

+ (void)moveFile:(NSString *)fromPath toPath: (NSString *)toPath;

+ (void)removeFileAtPath: (NSString *)path;

@end

NS_ASSUME_NONNULL_END
