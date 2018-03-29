//
//  WeatherView.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherView.h"



@interface WeatherView ()

@property (nonatomic ,strong) CAGradientLayer * gradient;

@property (strong, nonatomic) UILabel             *solLogoLabel;

@property (strong, nonatomic) UILabel             *weather;

@property (strong, nonatomic) UIView              *bgView;

@property (strong, nonatomic) UILabel             *temp;

@property (strong, nonatomic) UILabel             *humidity;

@property (strong, nonatomic) UILabel             *winds;

@property (strong, nonatomic) UILabel             *update;


@end


@implementation WeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    
    return self;
}




- (void)creatView {
    
    
    [self.layer addSublayer:self.gradient];
    
    //  Initialize the Sol° logo label
    self.solLogoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.solLogoLabel.center = CGPointMake(self.center.x, 0.5 * self.center.y);
    self.solLogoLabel.font = [UIFont fontWithName:CLIMACONS_FONT size:200];
    self.solLogoLabel.backgroundColor = [UIColor clearColor];
    self.solLogoLabel.textColor = [UIColor whiteColor];
    self.solLogoLabel.textAlignment = NSTextAlignmentCenter;
    self.solLogoLabel.text = [NSString stringWithFormat:@"%c", ClimaconSun];
    [self addSubview:self.solLogoLabel];
    
    
    self.weather = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 80)];
    self.weather.font = [UIFont fontWithName:@"Lato-Light" size:30];
    self.weather.center = CGPointMake(self.center.x, self.center.y);
    self.weather.numberOfLines = 2;
    self.weather.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.weather];
    
    
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 80)];
    self.bgView.center = CGPointMake(self.center.x, self.center.y * 1.4);
    self.bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [self addSubview:self.bgView];
    
    
    self.temp = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
//    self.temp.font = [UIFont fontWithName:@"Lato-Light" size:30];
//    self.temp.center = CGPointMake(self.center.x, self.center.y);
    self.temp.numberOfLines = 2;
    self.temp.textAlignment = NSTextAlignmentCenter;
    
    [self.bgView addSubview:self.temp];
    
    
    CGFloat w = (SCREEM_WIDTH - 100)/2;
    
    self.humidity = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, w, 80)];
    //    self.temp.font = [UIFont fontWithName:@"Lato-Light" size:30];
    //    self.temp.center = CGPointMake(self.center.x, self.center.y);
    self.humidity.numberOfLines = 2;
    self.humidity.textAlignment = NSTextAlignmentCenter;
    
    [self.bgView addSubview:self.humidity];
    
    
    self.winds = [[UILabel alloc]initWithFrame:CGRectMake(100+w, 0, w, 80)];
    //    self.temp.font = [UIFont fontWithName:@"Lato-Light" size:30];
    //    self.temp.center = CGPointMake(self.center.x, self.center.y);
    self.winds.numberOfLines = 2;
    self.winds.textAlignment = NSTextAlignmentCenter;
    
    [self.bgView addSubview:self.winds];
    
    
    self.update = [[UILabel alloc]initWithFrame:CGRectMake(15, self.height - 30, SCREEM_WIDTH - 30, 20)];
    self.update.font = FONT(12);
    self.update.textAlignment = NSTextAlignmentRight;
    self.update.textColor = [UIColor whiteColor];
    [self addSubview:self.update];
    
    
}


- (CAGradientLayer *)gradient {
    
    if(_gradient==nil){
        
        _gradient = [CAGradientLayer layer];
        
        _gradient.frame = self.bounds;
        
        [self.layer addSublayer:_gradient];
        
        self.gradient.colors = @[(id)RGB(248, 89, 63).CGColor,(id)RGB(252, 188, 132).CGColor];
        
        [self.layer addSublayer:self.gradient];
        
    }
    
    return _gradient;
}



- (void)setModel:(WeatherModel *)model {
    
    _model = model;
    
    
    self.gradient.colors = @[(id)_model.topColor.CGColor,(id)_model.bottomColor.CGColor];
    
    self.solLogoLabel.text = model.climacon;
    
    self.weather.attributedText = [model showWeather];
    self.weather.textAlignment = NSTextAlignmentCenter;
    
    
    self.temp.attributedText = [model showTemp];
    self.temp.textAlignment = NSTextAlignmentCenter;
    
    self.humidity.attributedText = [model showHumidity];
    self.humidity.textAlignment = NSTextAlignmentCenter;
    
    self.winds.attributedText = [model showWindspeed];
    self.winds.textAlignment = NSTextAlignmentCenter;
    
    self.update.text = model.showUpdate;
    
}




@end
