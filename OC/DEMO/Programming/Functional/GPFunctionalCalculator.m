//
//  GPFunctionalCalculator.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPFunctionalCalculator.h"

@implementation GPFunctionalCalculator

- (GPFunctionalCalculator *)compute:(NSInteger (^)(NSInteger))block{
    
    _result = block(_result);
    return self;
}

- (GPFunctionalCalculator *)log{
    NSLog(@"%ld",_result);
    return  self;
}

- (BOOL)equle:(NSInteger)value{
    return _result == value;
}
@end
