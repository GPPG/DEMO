//
//  FlagItem.h
//  01-导入RAC
//
//  Created by 小码哥 on 2017/3/4.
//  Copyright © 2017年 iThinkerYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPFlagItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
