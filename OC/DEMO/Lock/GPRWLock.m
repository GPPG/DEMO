//
//  GPRWLock.m
//  DEMO
//
//  Created by 郭鹏 on 2022/7/24.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPRWLock.h"
#import <pthread/pthread.h>
#import <objc/runtime.h>


@interface GPRWLock()
@property (strong, nonatomic) dispatch_queue_t queue;
@property (assign, nonatomic) pthread_rwlock_t lock;


@end


@implementation GPRWLock


- (void)rwlock{
    // 初始化锁
    pthread_rwlock_init(&_lock, NULL);
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [self read1];
        });
        dispatch_async(queue, ^{
            [self write1];
        });
    }
}

- (void)read1{
    pthread_rwlock_rdlock(&_lock);
    
    sleep(1);
    NSLog(@"%s", __func__);
    
    pthread_rwlock_unlock(&_lock);
}

- (void)write1{
    pthread_rwlock_wrlock(&_lock);
    
    sleep(1);
    NSLog(@"%s", __func__);
    
    pthread_rwlock_unlock(&_lock);
}

- (void)dealloc{
    pthread_rwlock_destroy(&_lock);
}



- (void)barrier{

    self.queue = dispatch_queue_create("rw_queue", DISPATCH_QUEUE_CONCURRENT);

    for (int i = 0; i < 10; i++) {
        dispatch_async(self.queue, ^{
            [self read];
        });
        
        dispatch_async(self.queue, ^{
            [self read];
        });
        
        dispatch_async(self.queue, ^{
            [self read];
        });
        
        dispatch_barrier_async(self.queue, ^{
            [self write];
        });
    }
}



- (void)read {
    sleep(1);
    NSLog(@"read");
}

- (void)write
{
    sleep(1);
    NSLog(@"write");
}


@end
