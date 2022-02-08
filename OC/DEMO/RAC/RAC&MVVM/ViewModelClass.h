//
//  GPBaseRac.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//
#import <Foundation/Foundation.h>
//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id data);
typedef void (^ErrorCodeBlock) (id data);;

@interface ViewModelClass : NSObject
@property (copy, nonatomic) ReturnValueBlock successBlock;
@property (copy, nonatomic) ErrorCodeBlock errorBlock;


// 传入交互的Block块
- (void)initWithBlock: (ReturnValueBlock) successBlock
            WithErrorBlock: (ErrorCodeBlock) errorBlock;
@end

