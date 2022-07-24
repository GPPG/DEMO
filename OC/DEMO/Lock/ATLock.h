//
//  AATLock.h
//  AATAdSDK
//
//

#import <Foundation/Foundation.h>
#import <pthread/pthread.h>
#import <objc/runtime.h>
//#import <pthread.h>


NS_ASSUME_NONNULL_BEGIN

#define LOCKNAME_C "AT_lock"
#define RWLOCKNAME_C "AT_rw_lock"
//#define RECURSIVELOCKNAME_C "AT_recursive_lock"

#if DEBUG
#define AT_C_ASSERT(condition, desc) \
    do { \
        if(!(condition)){ \
            printf("AT_Assert : file: %s, line: %u , desc: %s", __FILE__, __LINE__, desc);\
            abort();\
        }\
    } while(0)
#else
#define AT_C_ASSERT(condition, desc)
#endif


/// 锁_信号量_初始化
/// @Warning 在使用AT_lock时, 请注意 [1]重入case的死锁问题;  [2]当主线程参与锁时, 可能的watchdog风险
static inline
void AT_lock_init(id binder) {
    
    if (!binder) return;
    dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    objc_setAssociatedObject(binder, LOCKNAME_C, lock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 锁_信号量_加锁
static inline
void AT_lock(id binder) {
    
    if (!binder) return;
    dispatch_semaphore_t lock = objc_getAssociatedObject(binder, LOCKNAME_C);
    AT_C_ASSERT(lock, "AT_lock时,lock未获取,请检查是否init");
    if (lock) {
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    }
}

/// 锁_信号量_解锁
static inline
void AT_unlock(id binder) {
   
    if (!binder) return;
    dispatch_semaphore_t lock = objc_getAssociatedObject(binder, LOCKNAME_C);
    AT_C_ASSERT(lock, "AT_unlock时,lock未获取,请检查是否init");
    if (lock) {
        dispatch_semaphore_signal(lock);
    }
}

///锁_读写锁_初始化
static inline
void AT_rw_lock_init(id binder) {
    
    if (!binder) return;
    dispatch_queue_t queue = dispatch_queue_create("AT.rwlock.concurrent.com", DISPATCH_QUEUE_CONCURRENT);
    objc_setAssociatedObject(binder,RWLOCKNAME_C, queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

///锁_读写锁_读
static inline
id AT_read_lock(id binder, id(^block)(void)) {

    if (!binder || !block) return nil;
    dispatch_queue_t queue = objc_getAssociatedObject(binder, RWLOCKNAME_C);
    AT_C_ASSERT(queue, "AT_read_lock时, queue未获取,请检查是否执行AT_rw_lock_init()");
    if (queue) {
        __block id resultValue = nil;
        dispatch_sync(queue, ^{
            resultValue = block();
        });
        return resultValue;
    }
    return nil;
}

///锁_读写锁_写
static inline
void AT_write_lock(id binder, void(^block)(void)) {
    
    if (!binder || !block) return ;
    
    dispatch_queue_t queue = objc_getAssociatedObject(binder, RWLOCKNAME_C);
    AT_C_ASSERT(queue, "AT_write_lock时, queue未获取,请检查是否执行AT_rw_lock_init()");
    if (queue) {
        dispatch_barrier_async(queue, block);
    }
}

///锁_读写锁_重入锁  有使用场景时  按需添加  pthread_mutex_t  PTHREAD_MUTEX_RECURSIVE
//static inline
//void AT_recursive_lock(id binder)





NS_ASSUME_NONNULL_END
