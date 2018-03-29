//
//  WeatherViewController.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "WeatherShowView.h"

@interface WeatherViewController : BaseViewController

@property (nonatomic ,strong)NSString * bgImgName;

@property (nonatomic ,strong)WeatherModel * model;

@end
