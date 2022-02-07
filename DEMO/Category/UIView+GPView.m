//
//  UIView+GPView.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "UIView+GPView.h"

@implementation UIView (GPView)
+ (instancetype)viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
