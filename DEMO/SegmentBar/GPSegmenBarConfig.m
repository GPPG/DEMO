//
//  GPSegmenBarConfig.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/1.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPSegmenBarConfig.h"

@implementation GPSegmenBarConfig


+ (instancetype)defaultConfig {
    
    GPSegmenBarConfig *config = [[GPSegmenBarConfig alloc] init];
    config.exposeSegmentBarBackColor = [UIColor clearColor];
    config.exposeItemFont = [UIFont systemFontOfSize:15];
    config.exposeItemNormalColor = [UIColor lightGrayColor];
    config.exposeItemSelectColor = [UIColor redColor];
    
    config.exposeIndicatorColor = [UIColor redColor];
    config.exposeIndicatorHeight = 2;
    config.exposeIndicatorExtraW = 10;
    
    return config;
    
}

+ (GPSegmenBarConfig *(^)(NSString *))operateCode{
    
        return ^GPSegmenBarConfig *(NSString *string) {
            return [[GPSegmenBarConfig  alloc]init];
        };
}


- (GPSegmenBarConfig *(^)(UIColor *))itemNormalColor {

    return ^(UIColor *color){
        self.exposeItemNormalColor = color;
        return self;
    };
}

- (GPSegmenBarConfig *(^)(UIColor *))itemSelectColor {

    return ^(UIColor *color){
        self.exposeItemSelectColor = color;
        return self;
    };
}

- (GPSegmenBarConfig *(^)(UIColor *))segmentBarBackColor {

    return ^(UIColor *color){
        self.exposeSegmentBarBackColor = color;
        return self;
    };
}

- (GPSegmenBarConfig *(^)(UIColor *))indicatorColor {

    return ^(UIColor *color){
        self.exposeIndicatorColor = color;
        return self;
    };
}


- (GPSegmenBarConfig *(^)(CGFloat))indicatorHeight {

    return ^(CGFloat value){
        self.exposeIndicatorHeight = value;
        return self;
    };
}

- (GPSegmenBarConfig *(^)(CGFloat))indicatorExtraW {

    return ^(CGFloat value){
        self.exposeIndicatorExtraW = value;
        return self;
    };
}

- (GPSegmenBarConfig *(^)(UIFont *))itemFont {

    return ^(UIFont *font){
        self.exposeItemFont = font;
        return self;
    };
}



@end
