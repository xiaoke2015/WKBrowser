//
//  LoadReadyWindow.m
//  圆的放大动画效果
//
//  Created by limin on 17/5/7.
//  Copyright © 2017年 none. All rights reserved.
//

#import "LoadReadyWindow.h"

@implementation LoadReadyWindow

-(id)initWithFrame:(CGRect)frame imageName:(NSString *)name
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert + 1;
        [self makeKeyAndVisible];
        
//        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        
        self.presentView = [[UIImageView alloc]initWithFrame:(CGRect){0, 0,frame.size.width, frame.size.height}];
        self.presentView.image = [UIImage imageNamed:name];
        self.presentView.alpha = 1.0;
        [self addSubview:self.presentView];
        
        self.hidden = YES;
        
    }
    return self;
}
//0000000
- (void)makeOuttoAnimation {
     self.hidden = NO;
     [self circleBigger];
}
- (void)circleBigger {
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self addSubview:self.presentView];
    self.presentView.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:self.startFrame];
    CGFloat radius = [UIScreen mainScreen].bounds.size.height + 100;
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.startFrame, -radius, -radius)];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath;
    
    maskLayer.backgroundColor = (__bridge CGColorRef)([UIColor whiteColor]);
    
    self.presentView.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = 0.5f;
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    
}
/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{

    self.presentView.layer.mask = nil;
    
    if(self.animationStopOperation)
    {
        self.animationStopOperation();
    }

}

@end
