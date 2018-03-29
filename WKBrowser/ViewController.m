//
//  ViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/3.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ViewController.h"

#import "WKBrowserViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic ,strong)WKWebView * webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEM_WIDTH, SCREEM_HEIGHT - 44 - 64)];
    
    
    [self.view addSubview:_webView];
    
    NSString *url = @"http://wap.baidu.com";
    
    NSURLRequest *req = [[NSURLRequest  alloc]initWithURL:[NSURL URLWithString:url]];
    
    [_webView loadRequest:req];
    
    _webView.allowsBackForwardNavigationGestures = NO;
    _webView.allowsLinkPreview = YES;
    
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    
    [self.view addSubview:searchBarView];
    
    searchBarView.currentWebView = _webView;
    
    [self showAnnimation];
    
    
//    WKBrowserViewController * wkBrowser = [[WKBrowserViewController alloc]init];
//    
//    wkBrowser.view.frame = CGRectMake(0, 0, SCREEM_WIDTH *0.8, SCREEM_HEIGHT *0.8);
//    
//    [self.view addSubview:wkBrowser.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)btnAction {
    
    [self showAnnimation];
}




- (void)showAnnimation {
    
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)];
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7f, 0.7f, 0.7f)];
    
    popAnimation.values = @[value1,value2];
    
    popAnimation.keyTimes = @[@0.2f, @1.0f];
    
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    popAnimation.timingFunctions = @[function,function,function];
    
    [self.view.layer addAnimation:popAnimation forKey:nil];
    
    popAnimation.delegate = self;
    
    [popAnimation setAutoreverses:NO];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"animationDidStop");
}



@end
