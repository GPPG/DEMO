//
//  GPTabBarController.h
//  DEMO
//
//  Created by 郭鹏 on 2021/12/5.
//  Copyright © 2021 郭鹏. All rights reserved.

#import <Foundation/Foundation.h>

@interface GPTableTool : NSObject

/** 判断表格是否存在 */
+ (BOOL)isTableExists: (NSString *)tableName uid: (NSString *)uid;

/** 获取表格里面所有的字段 */
+ (NSArray *)getTableAllColumnNames: (NSString *)tableName uid: (NSString *)uid;

@end
