//
//  HUDManager.m
//  ExtendDemo
//
//  Created by yuyue on 2017/2/14.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "HUDManager.h"

#import "MBProgressHUD.h"






static HUDManager *manager = nil;
static MBProgressHUD * progresshud;

@interface HUDManager ()

@end

@implementation HUDManager




+ (void)alertText:(NSString*)text {
    
//    [progresshud hideAnimated:YES];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD* hud = [[MBProgressHUD alloc]initWithView:window];
    
    [window addSubview:hud];

    hud.mode = MBProgressHUDModeText;

    hud.detailsLabel.text = text;
    
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor ;
    
    [hud showAnimated:YES];
    
    [hud hideAnimated:YES afterDelay:1.5];
    
}



- (instancetype)init {
    
    self = [super init];

    return self;
}




+ (void)alertLoading {

    
    [progresshud hideAnimated:YES];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.detailsLabel.text = @"加载中...";
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor ;
    
//    [progresshud hideAnimated:YES];
    progresshud = hud;
//    [progresshud showAnimated:YES];
}


+ (void)alertHide {
    
    
    [progresshud hideAnimated:YES];
    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//
//    [MBProgressHUD hideHUDForView:window animated:YES];
    
    
}



@end
