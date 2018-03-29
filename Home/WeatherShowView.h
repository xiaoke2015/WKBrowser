//
//  WeatherShowView.h
//  Convertor
//
//  Created by 李加建 on 2017/9/4.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeatherModel.h"

#define REQUEST_URL_HEAD @"http://api.openweathermap.org/data/2.5/"

#define WEATHER_API_KEY @"0b0b4a71f90a8dd37c74fe8f38af9f3d"

@interface WeatherShowView : UIView




- (void)dataWithModel:(WeatherModel*)model  ;

@end
