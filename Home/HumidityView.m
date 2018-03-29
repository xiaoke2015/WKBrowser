//
//  HumidityView.m
//  Convertor
//
//  Created by 李加建 on 2017/9/5.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HumidityView.h"


@interface HumidityView ()
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CAShapeLayer *shapeForegroundLayer;


@property (nonatomic ,strong)UILabel *label1;


@end

@implementation HumidityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        [self creatUI];
    }
    
    return self;
}



- (void)creatUI {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, self.height/2 - 70, self.width - 30, 20)];
    label.textColor = [UIColor whiteColor];
    label.text = @"湿度";
    label.font = FONT14;
    [self addSubview:label];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/4, self.width, self.height/2)];
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [UIColor whiteColor];
    
    
    [self addSubview:_label1];
    
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = RGB(200, 200, 200).CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 2;
    
    // 圆环半径
    CGFloat radius = 40;
    
    // 圆环中心点
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:M_PI/4 endAngle: M_PI * 2 - M_PI/4 clockwise:YES];
    shapeLayer.path = thePath.CGPath;
    [self.layer addSublayer:shapeLayer];
    
    
    // 背景layer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = RGB(255, 255, 255).CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineWidth = 2;
    
    // 圆环半径
//    CGFloat radius = 40;
//    
//    // 圆环中心点
//    CGPoint center = CGPointMake(self.width/2, self.height/2);
//    
//    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:M_PI/4 endAngle: M_PI * 2 - M_PI/4 clockwise:YES];
    _shapeLayer.path = thePath.CGPath;
    [self.layer addSublayer:_shapeLayer];
    
    
   

}

- (void)dataWithModel:(WeatherModel*)model {
    
    _label1.attributedText = [model showHumidity];
    
    
    [self showAnmiDuration:2 from:0 to:[model.humidity floatValue]/100.f];
}

#pragma  展示动画
- (void)showAnmiDuration:(CFTimeInterval)duration from:(CGFloat)fromValue  to:(CGFloat)toValue {
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.repeatCount = 0;
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    pathAnimation.toValue = [NSNumber numberWithFloat:toValue];
    
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    //防止动画结束后回到初始状态
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    
    [self.shapeLayer addAnimation:pathAnimation forKey:nil];
    
}






@end
