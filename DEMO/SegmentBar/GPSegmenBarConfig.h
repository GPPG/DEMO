//
//  GPSegmenBarConfig.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/1.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface GPSegmenBarConfig : NSObject

+ (instancetype)defaultConfig;

/** 北京颜色 */
@property (nonatomic, strong) UIColor *exposeSegmentBarBackColor;

@property (nonatomic, strong) UIColor *exposeItemNormalColor;
@property (nonatomic, strong) UIColor *exposeItemSelectColor;
@property (nonatomic, strong) UIFont *exposeItemFont;

@property (nonatomic, strong) UIColor *exposeIndicatorColor;

@property (nonatomic, assign) CGFloat exposeIndicatorHeight;
@property (nonatomic, assign) CGFloat exposeIndicatorExtraW;


// 链式编程的改法
- (GPSegmenBarConfig *(^)(UIColor *color))itemNormalColor;
- (GPSegmenBarConfig *(^)(UIColor *color))itemSelectColor;
- (GPSegmenBarConfig *(^)(UIColor *color))segmentBarBackColor;
- (GPSegmenBarConfig *(^)(UIColor *color))indicatorColor;

- (GPSegmenBarConfig *(^)(CGFloat value))indicatorHeight;
- (GPSegmenBarConfig *(^)(CGFloat value))indicatorExtraW;

- (GPSegmenBarConfig *(^)(UIFont *font))itemFont;


+ (GPSegmenBarConfig *(^)(NSString *))operateCode;


@end

NS_ASSUME_NONNULL_END
