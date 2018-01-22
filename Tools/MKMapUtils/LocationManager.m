//
//  LocationManager.m
//  GitDemo
//
//  Created by yuyue on 2017/5/12.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "LocationManager.h"

#import <CoreLocation/CoreLocation.h>

#import <UIKit/UIKit.h>


@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic ,strong)CLLocationManager * locationManager;

@end

@implementation LocationManager




- (instancetype)init {
    
    self = [super init];
    
    [self locationinit];
    
    return self;
}



- (void)locationinit {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
}




- (void)findMe
{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager  didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [self.locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    
//    如果调用已经一次，不再执行 
    NSTimeInterval locationAge = - [location.timestamp timeIntervalSinceNow];
    if(locationAge > 1){
        return;
    }
    
    NSLog(@"%@  isok = %@",location,@(locationAge));
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
        CLPlacemark * placemark = [placemarks lastObject];
        
        NSString * city = placemark.locality;
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:city delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
        if(_getAddress != nil){
            
            double lng = location.coordinate.longitude;
            double lat = location.coordinate.latitude;
            
            _getAddress(city ,lng,lat);
        }
        
    }];
    
}


- (void)locationManager:(CLLocationManager *)manager  didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}





@end
