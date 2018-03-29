//
//  TempView.m
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "TempView.h"

@interface TempView ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer1;
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;

@end


@implementation TempView

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
    label.text = @"温度";
    label.font = FONT14;
    [self addSubview:label];
    
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2 - 50, self.height/2 +15, 50, 20)];
    _label1.font = FONT12;
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [UIColor whiteColor];
    [self addSubview:_label1];
    
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2, self.height/2 + 15, 50, 20)];
    _label2.font = FONT12;
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.textColor = [UIColor whiteColor];
    [self addSubview:_label2];
    
    [self addline1];
    
    [self addline2];
    
    [self addline3];

}



- (void)addline1 {
    
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    firstPath.lineCapStyle = kCGLineCapRound; //线条拐角
    firstPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [firstPath moveToPoint:CGPointMake(self.width/2 - 25, self.height/2 + 15)];
    
    // Draw the lines
    [firstPath addLineToPoint:CGPointMake(self.width/2 - 25, self.height/2 - 5)];
    [firstPath closePath];//第五条线通过调用closePath方法得到的
    
    [firstPath stroke];//Draws line 根据坐标点连线
    
    //第二、UIBezierPath和CAShapeLayer关联
    CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
    lineLayer2.frame = CGRectMake(0, 0, self.width, self.height);
    lineLayer2.fillColor = [UIColor clearColor].CGColor;
    lineLayer2.path = firstPath.CGPath;
    lineLayer2.lineWidth = 20;
    lineLayer2.strokeColor = [UIColor whiteColor].CGColor;
    
    self.shapeLayer1 = lineLayer2;
    
    //第三，动画
//    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
//    ani.fromValue = @0;
//    ani.toValue = @1;
//    ani.duration = 2;
//    [lineLayer2 addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
//    [self.layer addSublayer:lineLayer2];
}


- (void)addline2 {
    
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    firstPath.lineCapStyle = kCGLineCapRound; //线条拐角
    firstPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [firstPath moveToPoint:CGPointMake(self.width/2 + 25, self.height/2 + 15)];
    
    // Draw the lines
    [firstPath addLineToPoint:CGPointMake(self.width/2 + 25, self.height/2 - 25)];
    [firstPath closePath];//第五条线通过调用closePath方法得到的
    
    [firstPath stroke];//Draws line 根据坐标点连线
    
    //第二、UIBezierPath和CAShapeLayer关联
    CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
    lineLayer2.frame = CGRectMake(0, 0, self.width, self.height);
    lineLayer2.fillColor = [UIColor clearColor].CGColor;
    lineLayer2.path = firstPath.CGPath;
    lineLayer2.lineWidth = 20;
    lineLayer2.strokeColor = [UIColor whiteColor].CGColor;
    
    self.shapeLayer2 = lineLayer2;
    
    //第三，动画
//    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
//    ani.fromValue = @0;
//    ani.toValue = @1;
//    ani.duration = 2;
//    [lineLayer2 addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
//    [self.layer addSublayer:lineLayer2];
}



- (void)addAnimation {
    
    //第三，动画
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 2;
    [self.shapeLayer1 addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer:self.shapeLayer1];
    
    [self.shapeLayer2 addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer:self.shapeLayer2];
    
}



- (void)addline3 {
    
    UIBezierPath *firstPath = [UIBezierPath bezierPath];
    firstPath.lineCapStyle = kCGLineCapRound; //线条拐角
    firstPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [firstPath moveToPoint:CGPointMake(self.width/2 - 50, self.height/2 + 15)];
    
    // Draw the lines
    [firstPath addLineToPoint:CGPointMake(self.width/2 + 50, self.height/2 + 15)];
    [firstPath closePath];//第五条线通过调用closePath方法得到的
    
    [firstPath stroke];//Draws line 根据坐标点连线
    
    //第二、UIBezierPath和CAShapeLayer关联
    CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
    lineLayer2.frame = CGRectMake(0, 0, self.width, self.height);
    lineLayer2.fillColor = [UIColor clearColor].CGColor;
    lineLayer2.path = firstPath.CGPath;
    lineLayer2.lineWidth = 0.5;
    lineLayer2.strokeColor = [UIColor whiteColor].CGColor;
    
    //第三，动画
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 0;
    [lineLayer2 addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer:lineLayer2];
  
}


- (void)dataWithModel:(WeatherModel*)model {
    
    
    [self addAnimation];
    
    _label1.text = [NSString stringWithFormat:@"Min%@°",@([model.temp_min integerValue])];
    
    _label2.text = [NSString stringWithFormat:@"Max%@°",@([model.temp_max integerValue])];
}





@end
