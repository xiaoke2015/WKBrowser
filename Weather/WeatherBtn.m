//
//  WeatherBtn.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherBtn.h"


@interface WeatherBtn ()

@property (nonatomic ,strong)UILabel *solLogoLabel;

@property (nonatomic ,strong)UILabel *label;

@end

@implementation WeatherBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    CGFloat h = self.height;
    
    self.solLogoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, h, h)];
//    self.solLogoLabel.center = CGPointMake(self.center.x, 0.5 * self.center.y);
    self.solLogoLabel.font = [UIFont fontWithName:CLIMACONS_FONT size:40];
    self.solLogoLabel.backgroundColor = [UIColor clearColor];
    self.solLogoLabel.textColor = [UIColor whiteColor];
    self.solLogoLabel.textAlignment = NSTextAlignmentCenter;
    self.solLogoLabel.text = [NSString stringWithFormat:@"%c", ClimaconSun];
    [self addSubview:self.solLogoLabel];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(self.solLogoLabel.right, 0, SCREEM_WIDTH - self.solLogoLabel.right, h)];
    self.label.font = [UIFont fontWithName:@"Lato-Light" size:14];
    self.label.numberOfLines = 2;
    self.label.textColor = [UIColor whiteColor];
    [self addSubview:self.label];

    WeatherModel *model = [WeatherModel currentWeather];
    
    self.label.text = [NSString stringWithFormat:@"%@\n%@°",model.city_name,@([model.temp integerValue])];
    
}


- (void)setModel:(WeatherModel *)model {
    
    _model = model;
    
    self.solLogoLabel.text = model.climacon;
    
    self.label.text = [NSString stringWithFormat:@"%@\n%@°",model.city_name,@([model.temp integerValue])];
    
}




@end
