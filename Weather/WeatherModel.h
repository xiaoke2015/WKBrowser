//
//  WeatherModel.h
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#import "Climacons.h"

#define REQUEST_URL_HEAD @"http://api.openweathermap.org/data/2.5/"

#define WEATHER_API_KEY @"0b0b4a71f90a8dd37c74fe8f38af9f3d"

#define DictStr(dict ,key) [NSString stringWithFormat:@"%@",(dict[key]==nil?@"":dict[key])]


@interface WeatherModel : NSObject

@property (nonatomic ,assign)CLLocationCoordinate2D coord;

@property (nonatomic ,strong)NSString* weather_id;
@property (nonatomic ,strong)NSString* weather;
@property (nonatomic ,strong)NSString* weather_description;


@property (nonatomic ,strong)NSString* temp;
@property (nonatomic ,strong)NSString* pressure;
@property (nonatomic ,strong)NSString* humidity;// 湿度
@property (nonatomic ,strong)NSString* temp_min;
@property (nonatomic ,strong)NSString* temp_max;

@property (nonatomic ,strong)NSString* wind_speed;


@property (nonatomic ,strong)NSString* clouds;
@property (nonatomic ,strong)NSString* dt;
@property (nonatomic ,strong)NSString* sunrise;
@property (nonatomic ,strong)NSString* sunset;

@property (nonatomic ,strong)NSString* city_id;
@property (nonatomic ,strong)NSString* city_name;
@property (nonatomic ,strong)NSString* climacon;

@property (nonatomic ,strong)UIColor * topColor;
@property (nonatomic ,strong)UIColor * bottomColor;


+ (WeatherModel*)currentWeather ;


- (instancetype)initWithDict:(NSDictionary*)dict ;

- (void)modelWithDict:(NSDictionary*)dict ;

// 显示温度
- (NSAttributedString *)showTemp ;


- (NSAttributedString *)showWeather;


//显示湿度
- (NSAttributedString *)showHumidity ;

// 风速
- (NSAttributedString *)showWindspeed;

// 日出
- (NSString *)showSunrise ;
// 日落
- (NSString *)showSunset ;

// 更新时间
- (NSString *)showUpdate ;


- (NSString*)weatherType  ;

@end
