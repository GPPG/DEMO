//
//  GPPictureCycleProtocol.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/2.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GPPictureCycleProtocol <NSObject>
/**
 *  广告图片URL
 */
@property (nonatomic, copy, readonly) NSURL *adImgURL;


/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickBlock)();


@end

NS_ASSUME_NONNULL_END
