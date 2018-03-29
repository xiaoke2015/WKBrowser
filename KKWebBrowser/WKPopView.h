//
//  WKPopView.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "WeatherBtn.h"

@class WKPopView;

typedef void(^PopSelTag)(NSInteger tag);

typedef void(^PopSelTagBlock)(NSInteger tag ,WKPopView* popView);

@interface WKPopView : UIView


+ (void)showInView:(UIView*)view  success:(PopSelTag)success ;


+ (void)showInView:(UIView*)view  isWeb:(BOOL)isweb success:(PopSelTag)success ;

@end
