//
//  WKBrowserViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/6.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WKBrowserViewController.h"

#import "WKHomeViewController.h"

@interface WKBrowserViewController ()<UIScrollViewDelegate>



@end

@implementation WKBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.homeVC.view];
    
    self.isHome = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
//    [self.view addSubview:[WKSearchBarView shareInstance]];
}


- (WKWebView *)webView {
    
    if(_webView == nil){
        
        CGFloat h = (SCREEM_HEIGHT - 44 - 40);
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 40, SCREEM_WIDTH, h)];
        _webView.scrollView.delegate = self;
    }
    
    return _webView;
}



- (NSString *)wkTitle {
    
    if(_wkTitle == nil){
        _wkTitle = @"首页";
    }
    
    return _wkTitle;
}



- (void)loadReqWithURL:(NSString *)url {
    
//    url = @"http://wap.baidu.com";
    
    
    
    self.isHome = NO;
    
    NSURLRequest *req = [[NSURLRequest  alloc]initWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:req];
    
    [self.view addSubview:self.webView];
}


- (WKHomeViewController *)homeVC {
    
    if(_homeVC == nil){
        _homeVC = [[WKHomeViewController alloc]init];
        
        __weak typeof(self ) weak = self;
        _homeVC.tapURLBlock = ^(NSString *url) {
          
            [weak showWebView];
            [weak loadReqWithURL:url];
        };
    }
    
    return _homeVC;
}



- (void)showHomeView {
    
    self.isHome = YES;
    
    WKSearchBarView *searchBar = [WKSearchBarView shareInstance];
    
    [self.view addSubview:self.homeVC.view];
    
    [self.view addSubview:searchBar];
    
    self.homeVC.view.hidden = NO;

    self.webView.hidden = YES;
    
    searchBar.titleBtn.hidden = YES;
    searchBar.line.hidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [searchBar checkSearchStatus];
}



- (void)showWebView {
    
    self.isHome = NO;
    
    
    WKSearchBarView *searchBar = [WKSearchBarView shareInstance];
    

    [self.view addSubview:_webView];
    
    [self.view addSubview:searchBar];
    
    self.homeVC.view.hidden = YES;

    self.webView.hidden = NO;
    
    searchBar.titleBtn.hidden = NO;
    searchBar.line.hidden = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [searchBar checkSearchStatus];
}


@end
