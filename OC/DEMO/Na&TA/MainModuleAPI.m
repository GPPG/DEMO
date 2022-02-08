//
//  MainModuleAPI.m
//  DEMO
//
//  Created by 郭鹏 on 2022/1/30.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "MainModuleAPI.h"
#import "GPTabBar.h"
#import "GPTabBarController.h"
#import "GPNavBar.h"
#import "GPMiddleView.h"

@implementation MainModuleAPI
+ (GPTabBarController *)rootTabBarCcontroller {
    return [GPTabBarController shareInstance];
}


+ (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {

    [[GPTabBarController shareInstance] addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName isRequiredNavController:isRequired];

}


+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock {

    GPTabBar *tabbar = (GPTabBar *)[GPTabBarController shareInstance].tabBar;
    tabbar.middleClickBlock = middleClickBlock;

}

/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)setNavBarGlobalBackGroundImage: (UIImage *)globalImg {
    [GPNavBar setGlobalBackGroundImage:globalImg];
}
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)setNavBarGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize {

    [GPNavBar setGlobalTextColor:globalTextColor andFontSize:fontSize];

}

+ (UIView *)middleView {
    return [GPMiddleView middleView];
}


@end
