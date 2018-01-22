//
//  WeatherShowView.m
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherShowView.h"

#import "SunView.h"

#import "TempView.h"

#import "HumidityView.h"

#import "WindSpeedView.h"

@interface WeatherShowView ()

@property (nonatomic ,strong)UILabel *cityName;

@property (nonatomic ,strong)UILabel *temp;

@property (nonatomic ,strong)UILabel *clouds;

@property (nonatomic ,strong)UILabel *update;

@property (nonatomic ,strong)SunView *sumView;

@property (nonatomic ,strong)TempView *tempView;

@property (nonatomic ,strong)HumidityView *humidityView;

@property (nonatomic ,strong)WindSpeedView *windSpeedView;


@end

@implementation WeatherShowView

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
    
    
    [self createBackgroundView];
}


- (void)createBackgroundView {
    
    CGFloat x = 0;
    if(kDevice_Is_iPhoneX){
        x = 24;
    }
    
    _cityName = [[UILabel alloc]initWithFrame:CGRectMake(0, 20+x, SCREEM_WIDTH, 44)];
    _cityName.textAlignment = NSTextAlignmentCenter;
    _cityName.textColor = [UIColor whiteColor];
    _cityName.font = [UIFont fontWithName:@"Lato-Light" size:22];
    [self addSubview:_cityName];
    
//    _cityName.backgroundColor = [UIColor orangeColor];

    
    CGFloat hh = SCREEM_HEIGHT * 0.4;
    
    _temp = [[UILabel alloc]initWithFrame:CGRectMake(0, hh/2 - 20, SCREEM_WIDTH, hh/4)];
    
    _temp.textAlignment = NSTextAlignmentCenter;
    _temp.textColor = [UIColor whiteColor];
    [self addSubview:_temp];
//    _temp.font = [UIFont fontWithName:@"Lato-Light" size:60];
//    _temp.backgroundColor = [UIColor orangeColor];
    
    
    _clouds = [[UILabel alloc]initWithFrame:CGRectMake(0, _temp.bottom, SCREEM_WIDTH, 30)];
    _clouds.textAlignment = NSTextAlignmentCenter;
    _clouds.textColor = [UIColor whiteColor];
    _clouds.font = [UIFont fontWithName:@"Lato-Light" size:20];
    [self addSubview:_clouds];
    
    _update = [[UILabel alloc]initWithFrame:CGRectMake(0, _clouds.bottom, SCREEM_WIDTH, 20)];
    _update.textAlignment = NSTextAlignmentCenter;
    _update.textColor = [UIColor whiteColor];
    _update.font = FONT(12);
   
    [self addSubview:_update];
    
    
}



- (SunView*)sumView {
    
    if(_sumView == nil){
        
        CGFloat hh = SCREEM_HEIGHT * 0.4;
        CGFloat ccc = SCREEM_HEIGHT * 0.6;
        
        _sumView = [[SunView alloc]initWithFrame:CGRectMake(0, hh, SCREEM_WIDTH/2, ccc/2)];
        
        [self addSubview:_sumView];
    }
    return _sumView;
}


- (TempView*)tempView {
    
    if(_tempView == nil){
        
        CGFloat hh = SCREEM_HEIGHT * 0.4;
        CGFloat ccc = SCREEM_HEIGHT * 0.6;
        
        _tempView = [[TempView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2, hh, SCREEM_WIDTH/2, ccc/2)];
        
        [self addSubview:_tempView];
    }
    return _tempView;
}

- (HumidityView*)humidityView {
    
    if(_humidityView == nil){
        
        CGFloat hh = SCREEM_HEIGHT * 0.4;
        CGFloat ccc = SCREEM_HEIGHT * 0.6;
        
        _humidityView = [[HumidityView alloc]initWithFrame:CGRectMake(0, hh+ccc/2, SCREEM_WIDTH/2, ccc/2)];
        
        [self addSubview:_humidityView];
    }
    return _humidityView;
}


- (WindSpeedView*)windSpeedView {
    
    if(_windSpeedView == nil){
        
        CGFloat hh = SCREEM_HEIGHT * 0.4;
        CGFloat ccc = SCREEM_HEIGHT * 0.6;
        
        _windSpeedView = [[WindSpeedView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2, hh+ccc/2, SCREEM_WIDTH/2, ccc/2)];
        
        [self addSubview:_windSpeedView];
    }
    return _windSpeedView;
}

- (void)dataWithModel:(WeatherModel*)model {
    
    
    _cityName.text = model.city_name;
    
    _temp.attributedText = [model showTemp];
    
    _clouds.text = model.weather_description;
    
    _update.text = [model showUpdate];
    
    [self.sumView dataWithModel:model];

    [self.tempView dataWithModel:model];
    
    [self.humidityView dataWithModel:model];
    
    [self.windSpeedView dataWithModel:model];
}


@end
