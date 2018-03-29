//
//  MKMapUtils.h
//  AppleMap
//
//  Created by yuyue on 16-7-14.
//  Copyright (c) 2016年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

#import "LocationManager.h"

#import <CoreLocation/CoreLocation.h>

#import "MKMapView+MapViewUtil.h"


typedef void (^getCityBlock)(NSString *city);

typedef void (^getLocationBlock)(double lat ,double lng ,NSString *city);


@interface MKMapUtils : NSObject



// 反地理编码获取城市名称
+ (void)cityWithLocation:(CLLocation*)location  city:(getCityBlock)getCity ;


+ (double)distanceFromMe:(CLLocationCoordinate2D)me ToOther:(CLLocationCoordinate2D)other ;


+ (void)cityWithAddress:(NSString*)address  location:(getLocationBlock)getLocation ;


@end
