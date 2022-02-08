//
//  GPBaseRac.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPRACBaseLearning.h"
#import "ReactiveObjC.h"
#import "GPFlagItem.h"


@implementation GPRACBaseLearning
/*
 RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。

 使用场景:监听按钮点击，网络请求
   注意:
   1.RACCommand内部必须要返回signal
   2.executionSignals 信号中信号,一开始获取不到内部信号
       2.1 switchToLatest:获取内部信号
       2.2 execute:获取内部信号
   3.executing: 判断是否正在执行
       3.1 第一次不准确,需要skip,跳过
       3.2 一定要记得sendCompleted,否则永远不会执行完成
   4.execute执行,执行command的block
*/

- (void)demoCommand{
    // 创建Command
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        // Command的block
        NSLog(@"执行BlocK,%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            // 信号的block
            NSLog(@"执行信号的block");
            // 发送数据 => RACReplaySubject
            [subscriber sendNext:@"你好"];
            
            // 发送完成
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    // 订阅command信号
    // executionSignals: 信号中信号,信号发送信号
    // switchToLatest:获取最近发送的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    // 监听命令的执行情况 有没有完成
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        BOOL isExecuting = [x boolValue];
        
        if (isExecuting) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    
    RACReplaySubject *subject = [command execute:@1];
    
    [subject subscribeNext:^(id  _Nullable x) {
        
    }];
    
        // 怎么订阅command内部信号
    //    [[command execute:@1] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }]
}

/*
 RACMulticastConnection:用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。

 使用注意:RACMulticastConnection通过RACSignal的-publish或者-muticast:方法创建.
*/

- (void)demoMulticastConnection{
    
    @weakify(self)

    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
         @strongify(self);
         
         // 网络请求
         NSLog(@"发送请求");
         
         [self loadData:^(id data) {
             // subscriber  subject
             [subscriber sendNext:data];
             
         }];
         
         return nil;
     }];
    RACMulticastConnection *connection = [signal publish];
     
     // 订阅信号:sendNext
     // RACSubject:RACSubscribe
     [connection.signal subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
     }];
     
     [connection.signal subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
     }];
     
     // 进行连接
     /*
         RACSubject订阅signal
     */
     [connection connect];
    
    
}

- (void)loadData:(void(^)(id))success{
}
/*
 数据优化,开启一个异步线程去处理数据

 RAC集合:异步线程处理数据

 OC集合:数组,字典,NSSet
*/
- (void)demoSet{
    
    NSDictionary *dict = @{
                           @"name" : @"wangsicong",
                           @"money": @100000000
                           };
    
        // RACTuple:元组
        [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
    
            // 把元组解析出来
            RACTupleUnpack(NSString *key,id value) = x;
    
            /*
             NSString *key = x[0]
             id value = x[1]
             */
    
            NSLog(@"%@ %@",key,value);
        }];
        
        // 把值包装成元组
        RACTuple *tuple = RACTuplePack(@1,@3,@3);
        
        NSLog(@"%@",tuple);
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
       
       NSArray *datas = [NSArray arrayWithContentsOfFile:filePath];
       
       //    datas = @[@1,@2,@3];
       
       NSMutableArray *arrM = [NSMutableArray array];
       
       // 字典转模型
       // map:映射
       // mapBlock: value参数:集合  返回值:需要映射成那个值
       arrM = [[datas.rac_sequence map:^id _Nullable(id  _Nullable value) {
           return [GPFlagItem itemWithDict:value];
       }] array];
       
       NSLog(@"%@",arrM);
        
}


/*
   RACSubject：有多个订阅者
   RACSubject和RACReplaySubject：
   
   RACSubject即可以订阅，也可以发送消息

   共同点：既可以充当信号也可以充当订阅者
   不同点: RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。
 
   开发中：一个数据，需要多个类同时处理,使用RACSubject
   RACReplaySubject：保存值
   // RACSubject开发的时候，使用的比较多
   // RACSubject 代替代理

*/
- (void)demoSubject
{
    // 先订阅 在发送信号
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 订阅
    // 内部创建RACSubscriber，并且保存起来
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@",x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 发送信号
    // 遍历所有的订阅者，执行nextBlock
    [subject sendNext:@1];
}

- (void)demoReplaySubject{
    // 创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 发送信息
    // 先保存123
    [replaySubject sendNext:@"123"];
    [replaySubject sendNext:@"321"];
    
    // 订阅信号
    // 遍历值，让一个订阅者去发送多个值
    // 只要订阅一次，之前所有发送的值都能获取到.
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

/*
 
 RACSignal:信号，ReactiveCocoa最基本类
 RACDisposable:处理数据,清空数据
 block:什么时候执行，block能干嘛
 RACSubscriber:订阅者,发送信号消息
 信号本身不具备发送消息能力
 先订阅 在发送消息
 在订阅就会执行RACSignal的block
*/
- (void)demoSignal{
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送信号变化
        
        NSLog(@"RACSignal的block");
        // 网络请求
        
        
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            // 当订阅者被消耗的时候就会执行
            // 订阅发送完成或者error,也会执行Block
            // 清空数据
            NSLog(@"RACDisposable的block");
        }];
        
    }];
    
    // 订阅信号传的值
    // 底层：创建订阅者
    // 注意点：不要分开订阅，要一起订阅.
    [signal subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        
    }];
    
    //    [signal subscribeNext:^(id  _Nullable x) {
    //
    //        NSLog(@"信号传值的时候 %@",x);
    //    }];
    //
    //    // 订阅信号错误
    //    [signal subscribeError:^(NSError * _Nullable error) {
    //
    //    }];
    //
    //    // 订阅完成
    //    [signal subscribeCompleted:^{
    //
    //    }];
    
    
}

@end
