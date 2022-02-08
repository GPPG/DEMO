//
//  GPChainedCalculator.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPChainedCalculator.h"

@implementation GPChainedCalculator

- (GPChainedCalculator * (^)(NSInteger))add
{
    return ^(NSInteger value){
        
        self->_result += value;
        
        return self;
        
    };
}

- (void)dealloc{
    NSLog(@"销毁:%s",__func__);
}

@end
