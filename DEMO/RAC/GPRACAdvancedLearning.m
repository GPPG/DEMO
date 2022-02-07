//
//  GPRACAdvancedLearning.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPRACAdvancedLearning.h"
#import "ReactiveObjC.h"
#import "RACReturnSignal.h"

@interface GPRACAdvancedLearning()

@property (strong, nonatomic) UITextField *textField;

@end


@implementation GPRACAdvancedLearning

/*
 flattenMap，Map用于把源信号内容映射成新的内容
 1.FlatternMap中的Block返回信号。
 2.Map中的Block返回对象。
 3.开发中，如果信号发出的值不是信号，映射一般使用Map
 4.开发中，如果信号发出的值是信号，映射一般使用FlatternMap。
 总结：signalOfsignals用FlatternMap。
 */

- (void)demoFlattenMap{
//    flattenMap;信号中信号
    
          [[_textField.rac_textSignal flattenMap:^ RACSignal * (NSString * value) {
              NSString *result = [NSString stringWithFormat:@"xmg %@",value];
              return [RACReturnSignal return:result];
      
          }] subscribeNext:^(id  _Nullable x) {
      
              NSLog(@"%@",x);
      
          }];
      
      [[_textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
          NSString *result = [NSString stringWithFormat:@"xmg %@",value];
          return result;
      }] subscribeNext:^(id  _Nullable x) {
          NSLog(@"%@",x);
      }];
}


/*
 
 按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号。
 */

- (void)demoConcat {
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // 拼接concat
    
    // 需求:需要把两次请求的数据 添加到一个数组 有顺序的添加,先添加A,在添加B
    // 创建信号
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACReplaySubject subject];
    
    // 订阅信号
    NSMutableArray *arrM = [NSMutableArray array];
    
    // 按顺序拼接,必须要第一个信号发送完成,第二个信号才能获取值
    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        [arrM addObject:x];
    }];
    
//    [signalA subscribeNext:^(id  _Nullable x) {
//        [arrM addObject:x];
//    }];
//
//
//    [signalB subscribeNext:^(id  _Nullable x) {
//        [arrM addObject:x];
//    }];
    
    // 发送信号
    [signalB sendNext:@"B"];
    [signalA sendNext:@"A"];
    [signalA sendCompleted];
   
    // 打印数组的值
    NSLog(@"%@",arrM);
    
}

/*
 then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号。
 then:解决block嵌套问题
 */

- (void)demoThen{
     // then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    // 注意使用then，之前信号的值会被忽略掉.
    // 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
     
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@2];
            return nil;
        }];
    }] subscribeNext:^(id x) {
      
        // 只能接收到第二个信号的值，也就是then返回信号的值
        NSLog(@"%@",x);
    }];
}


/*
 // merge:合并,只要任何一个信号发送数据,就能订阅
 // concat:必须要A发送完成,B才能订阅
 // then:
 */
- (void)demoMerge {
    // 只要想无序的整合信号数据
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    [[signalA merge:signalB] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    // 发送
    [signalB sendNext:@"B"];
    [signalA sendNext:@"A"];
}

/*
 zipWith:把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件
 */

- (void)demoZip {
    
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    [[signalA zipWith:signalB] subscribeNext:^(id  _Nullable x) {
       
        RACTupleUnpack(NSString *a,NSString *b) = x;
        NSLog(@"%@ %@",a,b);
        
    }];
    
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B"];
}

/*
 combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
 reduce:分解，将元组里的值拆分出来
 */
- (void)demoCombineLatest{
     // 聚合
     // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
     // reduce中的block简介:
     // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
     // reduceblcok的返回值：聚合信号之后的内容。
    
     RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
    }];
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
     
        return [NSString stringWithFormat:@"%@ %@",num1,num2];
        
    }];
     
     [reduceSignal subscribeNext:^(id x) {
        
         NSLog(@"%@",x);
     }];
    
}
/*
 // filter:过滤
 */
- (void)demoFilter{
    
    // 过滤:
    // 每次信号发出，会先执行过滤条件判断.
    [_textField.rac_textSignal filter:^BOOL(NSString *value) {
            return value.length > 3;
    }];
    
}

@end
