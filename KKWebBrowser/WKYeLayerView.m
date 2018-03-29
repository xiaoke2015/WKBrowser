//
//  WKYeLayerView.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WKYeLayerView.h"


static WKYeLayerView *layerView = nil;

@interface WKYeLayerView ()

@property (nonatomic ,strong)CALayer *layer;

@end


@implementation WKYeLayerView



+ (WKYeLayerView*) shareInstance {
    
    if(layerView == nil){
        
        layerView = [[WKYeLayerView alloc]init];
        
    }
    
    [layerView checkYeMode];
    
    return layerView;
}


- (instancetype)init {
    
    self = [super init];
    
    
    _layer = [CALayer layer];
    
    _layer.backgroundColor = RGBA(0, 0, 0, 0.5).CGColor;
    _layer.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT);
    
    
    return self;
}



- (void)checkYeMode {
    
    BOOL isRecord = [[NSUserDefaults standardUserDefaults] boolForKey:@"yejian"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if(isRecord == YES){
        
        [window.layer addSublayer:self.layer];
    }
    else {
        
        [self.layer removeFromSuperlayer];
    }
    
}



@end
