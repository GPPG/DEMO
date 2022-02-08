//
//  GPChainedCalculator.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//


//    GPChainedCalculator *mgr = [[JiSuanQiManager alloc] init];
//
//    mgr.add(5).add(5).add(7).add(8);
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPChainedCalculator : NSObject

@property (nonatomic, assign) NSInteger result;



- (GPChainedCalculator *(^)(NSInteger))add;

@end

NS_ASSUME_NONNULL_END
