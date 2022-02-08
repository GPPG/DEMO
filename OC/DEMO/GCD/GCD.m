//
//  GCD.m
//  3333
//
//  Created by 郭鹏 on 2021/10/17.
//  Copyright © 2021 郭鹏. All rights reserved.
//

#import "GCD.h"

@implementation GCD

#pragma mark - 异步并发同步任务

- (void)asyncSync0{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncSync0 同步任务A");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncSync0 同步任务B");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncSync0 同步任务C");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"asyncSync0 任务完成执行");
    });
}

- (void)asyncSync1{
    
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
        NSLog(@"asyncSync1 任务A");
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"asyncSync1 任务B");
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"asyncSync1 任务C");
    });
    
    dispatch_barrier_async(queue1, ^{
        NSLog(@"asyncSync1 阻塞自定义并发队列");
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"asyncSync1 任务D");
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"asyncSync1 任务E");
    });

}
- (void)asyncSync2{
    
    NSBlockOperation *operatioon1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"asyncSync2 任务A");
    }];
    
    NSBlockOperation *operatioon2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"asyncSync2 任务B");
    }];
    
    NSBlockOperation *operatioon3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"asyncSync2 任务C");
    }];
    
    NSBlockOperation *operatioon4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"asyncSync2 任务D");
    }];
    
    [operatioon4 addDependency:operatioon1];
    [operatioon4 addDependency:operatioon2];
    [operatioon4 addDependency:operatioon3];
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    [queue2 addOperations:@[operatioon1,operatioon2,operatioon3,operatioon4] waitUntilFinished:YES];
    NSLog(@"asyncSync2 完成之后的操作");
    
}
#pragma mark - 异步并发（模拟网络异步任务）

// dispatch_group + semaphore
- (void)asyncAsync0{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncAsync0 同步任务A");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"asyncAsync0 网络异步任务一");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"asyncAsync0 同步任务B");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"asyncAsync0 网络异步任务二");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncAsync0 同步任务C");
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"asyncAsync0 同步任务D");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"asyncAsync0 网络异步任务四");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"asyncAsync0 任务完成执行");
    });


    
}

// dispatch_group_enter 和 dispatch_group_leave
- (void)asyncAsync1{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncAsync1 同步任务A");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"asyncAsync1 网络异步任务一");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"asyncAsync1 同步任务B");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"asyncAsync1 网络异步任务二");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSLog(@"asyncAsync1 同步任务C");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        NSLog(@"asyncAsync1 同步任务D");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"asyncAsync1 网络异步任务四");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"asyncAsync1 任务完成执行");
    });
}


#pragma mark - 异步串行（同步任务）
// 必然事件

#pragma mark - 异步串行（异步任务）

- (void)syncAsync0{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"syncAsync0 执行任务一");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"syncAsync0 网络任务一");
            dispatch_semaphore_signal(semaphore);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"syncAsync0 执行任务二");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"syncAsync0 网络任务二");
            dispatch_semaphore_signal(semaphore);
        });
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"syncAsync0 执行任务三");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"syncAsync0 执行完成");
        dispatch_semaphore_signal(semaphore);
    });
}

- (void)syncAsync1{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"syncAsync1 执行任务一");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"syncAsync1 网络任务一");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"syncAsync1 执行任务二");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"syncAsync1 网络任务二");
            dispatch_semaphore_signal(semaphore);
        });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    });
    
    dispatch_async(queue, ^{
        NSLog(@"syncAsync1 执行任务三");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"syncAsync1 执行完成");
    });
}


@end
