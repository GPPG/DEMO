//
//  GPFunctionalCalculator.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//


//GPFunctionalCalculator *mgr = [[GPFunctionalCalculator alloc] init];


//BOOL isReal = [[mgr compute:^(NSInteger reslut){
//    // 计算的代码 写在这里面
//    reslut+=5;
//    reslut+=5;
//    reslut+=5;
//    reslut+=5;
//
//    return reslut;
//}] equle:20];



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPFunctionalCalculator : NSObject

@property (nonatomic, assign) NSInteger result;

- (void)add:(NSInteger)value;
- (void)sub:(NSInteger)value;

- (GPFunctionalCalculator *)compute:(NSInteger(^)(NSInteger))block;

- (GPFunctionalCalculator *)log;

- (BOOL)equle:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
