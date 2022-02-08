//
//  MainModuleAPI.h
//  DEMO
//
//  Created by 郭鹏 on 2022/1/30.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MainModuleAPI : NSObject

/**
 获取根控制器

 @return rootTabBarCcontroller
 */
+ (UITabBarController *)rootTabBarCcontroller;

/**
 添加子控制器

 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 @param isRequired        是否需要包装导航控制器
 */
+ (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired;

/**
 设置tabbar中间控件的点击代码块

 @param middleClickBlock 点击代码块
 */
+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock;


/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)setNavBarGlobalBackGroundImage: (UIImage *)globalImg;
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)setNavBarGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize;



@end

NS_ASSUME_NONNULL_END
