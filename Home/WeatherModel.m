//
//  WeatherModel.m
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel




- (instancetype)initWithDict:(NSDictionary*)dict {
    
    self = [super init];

    // 经纬度
    NSDictionary *coord = dict[@"coord"];

    self.coord = CLLocationCoordinate2DMake([coord[@"lat"] floatValue], [coord[@"lon"] floatValue]);
    
    // 天气
    NSArray *weather = dict[@"weather"];
    
    if(weather.count > 0){

        NSDictionary *dd = weather[0];
        self.weather_id = DictStr(dd, @"id");
        self.weather = DictStr(dd, @"main");
        self.weather_description = DictStr(dd, @"description");
    }
    

    // 温度
    NSDictionary *main = dict[@"main"];
    
    self.temp = DictStr(main, @"temp");
    self.pressure = DictStr(main, @"pressure");
    self.humidity = DictStr(main, @"humidity");
    self.temp_min = DictStr(main, @"temp_min");
    self.temp_max = DictStr(main, @"temp_max");
    
    // 风速
    
    NSDictionary *wind = dict[@"wind"];
    self.wind_speed = DictStr(wind, @"speed");
    
    // 云朵
    NSDictionary *clouds = dict[@"clouds"];
    self.clouds = DictStr(clouds, @"all");
    
    // 时间
    self.dt = DictStr(dict, @"dt");
    
    // 日出 和日落
    
    NSDictionary * sys = dict[@"sys"];
    self.sunrise = DictStr(sys, @"sunrise");
    self.sunset = DictStr(sys, @"sunset");

    // 城市
    
    self.city_id = DictStr(dict, @"id");
    self.city_name = DictStr(dict, @"name");
    
    NSString *weater = [self weatherType];
    
    NSLog(@"%@",weater);
    
    return self;
}




- (NSAttributedString *)showTemp {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:60]};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:60]};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",@([_temp integerValue])] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"°"] attributes:attributes2];
    
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
//    NSString *showTemp = [NSString stringWithFormat:@"%@°C",@([_temp integerValue])];
    
//    return  showTemp;
    
    return attriString;
    
}


- (NSAttributedString *)showHumidity {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:35]};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:RGB(255, 255, 255),NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:14]};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",@([_humidity integerValue])] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%%"] attributes:attributes2];
    
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
    //    NSString *showTemp = [NSString stringWithFormat:@"%@°C",@([_temp integerValue])];
    
    //    return  showTemp;
    
    return attriString;
    
}


- (NSString *)showSunrise {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_sunrise integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}


- (NSString *)showSunset {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_sunset integerValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];

    return strDate;
}



- (NSString *)showUpdate {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_dt integerValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    NSString * string = [NSString stringWithFormat:@"%@ 更新",strDate];
    
    return string;
}

- (NSAttributedString *)showWindspeed {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:12]};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f",[_wind_speed floatValue]] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" mps"] attributes:attributes2];
    
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
    //    NSString *showTemp = [NSString stringWithFormat:@"%@°C",@([_temp integerValue])];
    
    //    return  showTemp;
    
    return attriString;
}


- (NSString*)weatherType {
    
    NSString* type = @"1";
    
    NSInteger tag = [_weather_id integerValue];
    
    if(tag == 800 || tag == 801 ){
        type = @"1";
        //sun
        
        self.weather_img = @"weather_001";
        self.weather_bg_img = @"weather_bg_001";
    }
    else if (tag == 300 || tag == 701 || tag == 721 || tag == 802 || tag == 803 || tag == 804){
        type = @"2";
        //clouds
        self.weather_img = @"weather_002";
        self.weather_bg_img = @"weather_bg_002";
    }
    else if (tag >= 200 && tag < 600){
        type = @"3";
        //rain
        self.weather_img = @"weather_004";
        self.weather_bg_img = @"weather_bg_004";
    }
    else if (tag >= 600 && tag < 700){
        type = @"4";
        //snow
        self.weather_img = @"weather_007";
        self.weather_bg_img = @"weather_bg_007";
    }
    else {
        type = @"2";
        self.weather_img = @"weather_002";
        self.weather_bg_img = @"weather_bg_002";
    }
    
    return type;
}





@end
