//
//  GPBaseRac.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "GPFlagItem.h"

@implementation GPFlagItem
+ (instancetype)itemWithDict:(NSDictionary *)dict
{
    GPFlagItem *item = [[self alloc] init];
    
    [item setValuesForKeysWithDictionary:dict];
    
    return item;
}
@end
