//
//  WindSpeedView.m
//  Convertor
//
//  Created by 李加建 on 2017/9/5.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WindSpeedView.h"


@interface WindSpeedView ()

@property (nonatomic ,strong)UIImageView *image;

@property (nonatomic ,strong)UILabel *label1;

@end

@implementation WindSpeedView

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
    label.text = @"风速";
    label.font = FONT14;
    [self addSubview:label];
    
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2 - 40, self.height/2 - 30, 60, 60)];
    _image.image = [UIImage imageNamed:@"windspeed"];
    [self addSubview:_image];
    
    //旋转动画
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 2;
    rotationAnimation.repeatCount = MAXFLOAT;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    [_image.layer addAnimation:rotationAnimation forKey:nil];
    
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2 + 20, self.height/2 + 20, 100, 20)];
    _label1.font = FONT(12);
    _label1.textColor = [UIColor whiteColor];
    [self addSubview:_label1];
}



- (void)dataWithModel:(WeatherModel*)model  {
    
    _label1.attributedText = [model showWindspeed];
}

@end
