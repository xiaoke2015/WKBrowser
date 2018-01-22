//
//  MKMapView+MapViewUtil.h
//  AppleMap
//
//  Created by yuyue on 16-7-13.
//  Copyright (c) 2016年 incredibleRon. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (MapViewUtil)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
