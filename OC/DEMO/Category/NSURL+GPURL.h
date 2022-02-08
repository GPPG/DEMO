//
//  NSURL+GPURL.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/3.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (GPURL)
- (NSURL *)streamingURL;

- (NSURL *)httpURL;

@end

NS_ASSUME_NONNULL_END
