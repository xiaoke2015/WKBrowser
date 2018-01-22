//
//  LocationManager.h
//  GitDemo
//
//  Created by yuyue on 2017/5/12.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^GetAddress)(NSString * city,double lng ,double lat);


@interface LocationManager : NSObject

@property (nonatomic ,copy)GetAddress getAddress ;


- (void)findMe ;

@end
