//
//  GPTabBarController.h
//  DEMO
//
//  Created by 郭鹏 on 2021/12/5.
//  Copyright © 2021 郭鹏. All rights reserved.


#import <Foundation/Foundation.h>

@protocol GPAudioDownLoaderDelegate <NSObject>

- (void)downLoaderLoading;

@end


@interface GPAudioDownLoader : NSObject

@property (nonatomic, assign) long long loadedSize;
@property (nonatomic, assign) long long offset;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, assign) long long totalSize;

@property (nonatomic, weak) id<GPAudioDownLoaderDelegate> delegate;

- (void)downLoadWithURL: (NSURL *)url offset: (long long)offset;


@end
