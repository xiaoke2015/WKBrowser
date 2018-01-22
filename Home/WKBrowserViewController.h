//
//  WKBrowserViewController.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/6.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKHomeViewController.h"

@interface WKBrowserViewController : UIViewController

@property (nonatomic ,strong)NSString *wkTitle;

//网页浏览器
@property (nonatomic ,strong)WKWebView * webView;

@property (nonatomic ,strong)NSString * url;

//首页
@property (nonatomic ,strong)WKHomeViewController *homeVC;

@property (nonatomic ,assign)BOOL isHome;






- (void)loadReqWithURL:(NSString *)url ;


- (void)showHomeView  ;


- (void)showWebView ;

@end
