//
//  MKMapUtils.m
//  AppleMap
//
//  Created by yuyue on 16-7-14.
//  Copyright (c) 2016年 incredibleRon. All rights reserved.
//

#import "MKMapUtils.h"

#import "HUDManager.h"

@implementation MKMapUtils




+ (void)cityWithLocation:(CLLocation*)location  city:(getCityBlock)getCity {
    
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:31.19 longitude:121.48];
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    
    [revGeo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(!error && [placemarks count]  >0){
            
            CLPlacemark *dict = [placemarks objectAtIndex:0] ;
            
            NSDictionary *area = [dict addressDictionary];
            
            NSString *city = area[@"City"];
            
            NSLog(@"%@",city);
            
            getCity (city);
            
        }
        else {
            NSLog(@"ERROR: %@", error);
        }
        
        
    }];
    

}




#pragma mark - calculate distance  根据2个经纬度计算距离

#define PI 3.1415926


+ (double)distanceFromMe:(CLLocationCoordinate2D)me ToOther:(CLLocationCoordinate2D)other {
    
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*me.latitude/180.0f;
    double radlat2 = PI*other.latitude/180.0f;
    //now long.
    double radlong1 = PI*me.longitude/180.0f;
    double radlong2 = PI*other.longitude/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    
    return dist;
    
}





+ (void)cityWithAddress:(NSString*)address  location:(getLocationBlock)getLocation{
    
    [HUDManager alertLoading];
    
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    
    [revGeo geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
        [HUDManager alertHide];
        
        if(!error && [placemarks count]  >0){
            
            CLPlacemark *dict = [placemarks objectAtIndex:0] ;
            
            NSDictionary *area = [dict addressDictionary];
            
            NSString *city = area[@"SubLocality"];
            
            NSLog(@"%@",city);
            
            CLLocation *location = dict.location;
            
            getLocation(location.coordinate.latitude ,location.coordinate.longitude ,city);
            
//            getCity (city);
            
        }
        else {
            
            NSLog(@"ERROR: %@", error);
        }
        
        
        
    }];
    
}






@end
