//
//  UIImage+ColorImage.m
//  DongJie
//
//  Created by yuyue on 2017/8/9.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)


+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}



@end
