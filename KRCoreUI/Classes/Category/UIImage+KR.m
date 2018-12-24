//
//  UIImage+LC.m
//  iOS-LQB
//
//  Created by RK on 2017/7/5.
//  Copyright © 2017年 顾荣康. All rights reserved.
//

#import "UIImage+KR.h"

@implementation UIImage (KR)

+ (UIImage *)kr_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
