//
//  GPTabBarController.h
//  DEMO
//
//  Created by 郭鹏 on 2021/12/5.
//  Copyright © 2021 郭鹏. All rights reserved.

#import "UIImage+GPImage.h"

@implementation UIImage (GPImage)

+ (UIImage *)originImageWithName: (NSString *)name {

    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

- (UIImage *)circleImage {

    CGSize size = self.size;
    CGFloat drawWH = size.width < size.height ? size.width : size.height;


    // 1. 开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(drawWH, drawWH));
    // 2. 绘制一个圆形区域, 进行裁剪
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect clipRect = CGRectMake(0, 0, drawWH, drawWH);
    CGContextAddEllipseInRect(context, clipRect);
    CGContextClip(context);

    // 3. 绘制大图片
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:drawRect];

    // 4. 取出结果图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();

    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;

}

@end
