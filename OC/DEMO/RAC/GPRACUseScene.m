//
//  GPRACDemo.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPRACUseScene.h"
#import "ReactiveObjC.h"
@interface GPRACUseScene()
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *label;

@property (nonatomic, assign) int age;

@end

/*
   1.监听某个方法有没有调用(rac_signalForSelector:判断有没有调用某个方法)
   2.代替KVO
   3.监听事件
   4.代替通知
   5.监听文本框文字改变
   6.处理一个界面,多个请求的问题
*/

@implementation GPRACUseScene

// 监听某个方法有没有调用(rac_signalForSelector:判断有没有调用某个方法)
- (void)demo1{
 
    
    //    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"ViewDidLoad");
    //    }];
    //
    //    // ViewWillAppear
    //    [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"ViewWillAppear");
    //    }];
}
// 代替KVO
- (void)demo2{
    // KVO
      //    [self rac_valuesForKeyPath:nil observer:nil];
      //    [self rac_valuesAndChangesForKeyPath:nil options:nil observer:nil];
      // keypath(self,age) == @"age"
      
      //    [[self rac_valuesForKeyPath:@keypath(self,age) observer:self] subscribeNext:^(id  _Nullable x) {
      //        NSLog(@"%@",x);
      //    }];
      
      // KVO宏 @"age" 直接写属性名,不要包装成字符串
      [RACObserve(self, age) subscribeNext:^(id  _Nullable x) {
          NSLog(@"%@",x);
      }];
}
// 监听事件
- (void)demo3{
    [[self.button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(__kindof UIControl * _Nullable x) {
           NSLog(@"%@",x);
       }];
}
// 代替通知
- (void)demo4{
    // 监听通知
    // 管理观察者:不需要管理观察者,RAC内部管理
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"Note" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"监听到通知%@",x);
    }];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Note" object:nil];
}

// 监听文本框文字改变
- (void)demo5{
    //    [_textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
     //    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
     ////        NSLog(@"%@",x);
     //        _label.text = x;
     //    }];
     
     // 绑定
     RAC(_label,text) = _textField.rac_textSignal;
}

// 处理一个界面,多个请求的问题
- (void)demo6{
    
    
    // 创建请求最热数据信号
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 请求最热信号
        [subscriber sendNext:@"最热数据"];
        
        return nil;
    }];
    
    // 创建请求最新数据信号
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // 请求最新的数据
        [subscriber sendNext:@"最新数据"];
        
        return nil;
    }];
    
    // Selector:当数组所有信号都发送next
    // rac_liftSelector硬性要求:有几个信号就必须有几个参数,参数就是信号发出值
    [self rac_liftSelector:@selector(updateUIWithHot:new:) withSignalsFromArray:@[hotSignal,newSignal]];
}
- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new
{
    NSLog(@"更新UI %@ %@",hot,new);
}
@end
