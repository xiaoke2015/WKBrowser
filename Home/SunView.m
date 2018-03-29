//
//  SunView.m
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SunView.h"


@interface SunView ()

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;

@end

@implementation SunView

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
    label.text = @"日出/日落";
    label.font = FONT14;
    [self addSubview:label];
    
//    self.backgroundColor = [UIColor redColor];
    
    UIImageView *imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2 - 40, self.height/2-30, 30, 30)];
    imgLeft.image = [UIImage imageNamed:@"sunrise"];
    [self addSubview:imgLeft];
    
    
    
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2 - 45, self.height/2 +10, 40, 20)];
    _label1.font = FONT12;
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.textColor = [UIColor whiteColor];
    [self addSubview:_label1];
    
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _label1.width, 0.5)];
    line1.backgroundColor = [UIColor whiteColor];
    [_label1 addSubview:line1];
    
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2, self.height/2 - 25, 40, 20)];
    _label2.font = FONT12;
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.textColor = [UIColor whiteColor];
    [self addSubview:_label2];
    
    UIImageView *imgRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2+5, self.height/2+5, 30, 30)];
    imgRight.image = [UIImage imageNamed:@"sunset"];
    [self addSubview:imgRight];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label2.height, _label2.width, 0.5)];
    line2.backgroundColor = [UIColor whiteColor];
    [_label2 addSubview:line2];
    
}



- (void)dataWithModel:(WeatherModel*)model {
    
    _label1.text = [model showSunrise];
    
    _label2.text = [model showSunset];
}




@end
