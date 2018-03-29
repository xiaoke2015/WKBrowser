//
//  WeatherModel.m
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel




+ (WeatherModel*)currentWeather {
    
    static WeatherModel *model = nil;
    static dispatch_once_t once_t;
    
    dispatch_once(&once_t, ^{
        
        model = [[WeatherModel alloc] init];
        
        model.city_name = @"北京市";
        model.temp = @"20°";
        model.coord = CLLocationCoordinate2DMake(39.9, 116.3);
        
        model.topColor = RGB(248, 89, 63);
        model.bottomColor = RGB(252, 188, 132);
        
    });
    
    return model;
}



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
    
//    self.city_id = DictStr(dict, @"id");
//    self.city_name = DictStr(dict, @"name");
    
    NSString *weater = [self weatherType];
    
    NSLog(@"%@",weater);
    
    return self;
}



- (void)modelWithDict:(NSDictionary*)dict {
    
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
//    
//    self.city_id = DictStr(dict, @"id");
//    self.city_name = DictStr(dict, @"name");
    
    NSString *weater = [self weatherType];
    
    NSLog(@"%@",weater);
}




- (NSAttributedString *)showTemp {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:38]};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:14]};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@° \n",@([_temp integerValue])] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"L %@°   ",@([_temp_min integerValue])] attributes:attributes2];
    
    NSAttributedString * attri3 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"H %@°",@([_temp_max integerValue])] attributes:attributes2];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    [attriString appendAttributedString:attri3];
    
//    NSString *showTemp = [NSString stringWithFormat:@"%@°C",@([_temp integerValue])];
    
//    return  showTemp;
    
    return attriString;
    
}



- (NSAttributedString *)showWeather {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    //    paragraphStyle.firstLineHeadIndent = 20.f;//首行缩进
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:30],NSParagraphStyleAttributeName:paragraphStyle};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:14],NSParagraphStyleAttributeName:paragraphStyle};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_weather_description] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n"] attributes:attributes];
    
    NSAttributedString * attri3 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",_city_name] attributes:attributes2];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    [attriString appendAttributedString:attri3];
    
    //    NSString *showTemp = [NSString stringWithFormat:@"%@°C",@([_temp integerValue])];
    
    //    return  showTemp;
    
    return attriString;
    
}


- (NSAttributedString *)showHumidity {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:30]};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:RGB(255, 255, 255),NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:14]};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",@([_humidity integerValue])] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%%"] attributes:attributes2];
    
     NSAttributedString * attri3 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"湿度\n"] attributes:attributes2];
    
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri3];
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
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:30]};
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:12]};
    
    NSDictionary *attributes3 = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Lato-Light" size:14]};
    
    NSAttributedString * attri1 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.1f",[_wind_speed floatValue]] attributes:attributes];
    
    NSAttributedString * attri2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" mps"] attributes:attributes2];
    
    NSAttributedString * attri3 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"风速\n"] attributes:attributes3];
    
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri3];
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
     
        self.topColor = RGB(248, 89, 63);
        self.bottomColor = RGB(252, 188, 132);
        
        self.climacon = [NSString stringWithFormat:@"%c", ClimaconSun];
     
    }
    else if (tag == 300 || tag == 701 || tag == 721 || tag == 802 || tag == 803 || tag == 804){
        type = @"2";
        //clouds
      
        self.topColor = RGB(37, 122, 236);
        self.bottomColor = RGB(134, 243, 253);
        
        self.climacon = [NSString stringWithFormat:@"%c", ClimaconCloud];
    }
    else if (tag >= 200 && tag < 600){
        type = @"3";
        //rain
        
        self.topColor = RGB(72, 103, 251);
        self.bottomColor = RGB(150, 214, 252);
        
        self.climacon = [NSString stringWithFormat:@"%c", ClimaconRain];
      
    }
    else if (tag >= 600 && tag < 700){
        type = @"4";
        //snow
        
        self.topColor = RGB(118, 88, 241);
        self.bottomColor = RGB(211, 181, 220);
        
        self.climacon = [NSString stringWithFormat:@"%c", ClimaconSnow];
       
    }
    else {
        type = @"2";
        
        self.topColor = RGB(248, 89, 63);
        self.bottomColor = RGB(252, 188, 132);
       
    }
    
    return type;
}





@end
