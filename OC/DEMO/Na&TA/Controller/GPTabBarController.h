//
//  GPTabBarController.h
//  DEMO
//
//  Created by 郭鹏 on 2021/12/5.
//  Copyright © 2021 郭鹏. All rights reserved.


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPTabBarController : UITabBarController

/**
 获取单例对象

 @return TabBarController
 */
+ (instancetype)shareInstance;


/**
 添加子控制器的block

 @param addVCBlock 添加代码块

 @return TabBarController
 */
+ (instancetype)tabBarControllerWithAddChildVCsBlock: (void(^)(GPTabBarController *tabBarC))addVCBlock;


/**
 添加子控制器

 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 @param isRequired        是否需要包装导航控制器
 */
- (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired;



@end

NS_ASSUME_NONNULL_END
