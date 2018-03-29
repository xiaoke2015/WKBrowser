//
//  WKSearchBarView.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/6.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WKSearchBarView.h"

#import "WKPopView.h"

#import "RecordViewController.h"

#import "SettingsViewController.h"

#import "CollectViewController.h"

static WKSearchBarView * searchbarView = nil;

@interface WKSearchBarView () <WKNavigationDelegate ,WKUIDelegate >

//返回
@property (nonatomic ,strong)UIButton * goBackBtn;
//前进
@property (nonatomic ,strong)UIButton * goForwardBtn;
//更多
@property (nonatomic ,strong)UIButton * goMoreBtn;
//首页
@property (nonatomic ,strong)UIButton * goHomeBtn;
//添加页面
@property (nonatomic ,strong)UIButton * goPageBtn;

//页面数量
@property (nonatomic ,strong)UILabel * pageLabel;




@end


@implementation WKSearchBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (WKSearchBarView *)shareInstance {
    
    if(searchbarView == nil){
        
        searchbarView = [[WKSearchBarView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 44, SCREEM_WIDTH, 44)];
        searchbarView.backgroundColor = RGB(240, 240, 240);
        
        NSLog(@"pageArray = %@",searchbarView.pageArray);
        
        searchbarView.delArray = [NSMutableArray array];
        
        searchbarView.city = @"北京市";
        searchbarView.lat = 39.9;
        searchbarView.lng = 116.3;
    }
    
    return searchbarView;
}


#pragma mark - 
#pragma mark 页面管理器
// 页面管理器
- (NSMutableArray*)pageArray {
    
    if(_pageArray == nil){
        _pageArray = [NSMutableArray array];
        
        WKBrowserViewController * nextVC = [[WKBrowserViewController alloc]init];
        
        [_pageArray addObject:nextVC];
        
        _currentWebViewVC = nextVC;
        _currentWebView = nextVC.webView;
    }
    
    return _pageArray;
}

#pragma mark -
#pragma mark 添加页面
- (void)addPage {
    
    WKBrowserViewController * nextVC = [[WKBrowserViewController alloc]init];
    [self.pageArray addObject:nextVC];
    
}




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatBtns];
    
    return self;
}


- (void)creatBtns {
    
    CGFloat w = self.width/5;
    
    _goBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, w, self.height)];
    [_goBackBtn setImage:[UIImage imageNamed:@"search_back_n"] forState:UIControlStateNormal];
    [_goBackBtn setImage:[UIImage imageNamed:@"search_back_s"] forState:UIControlStateSelected];
    [self addSubview:_goBackBtn];
    
    
    _goForwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(w, 0, w, self.height)];
    [_goForwardBtn setImage:[UIImage imageNamed:@"search_forward_n"] forState:UIControlStateNormal];
    [_goForwardBtn setImage:[UIImage imageNamed:@"search_forward_s"] forState:UIControlStateSelected];
    [self addSubview:_goForwardBtn];
    
    
    _goMoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(w*2, 0, w, self.height)];
    [_goMoreBtn setImage:[UIImage imageNamed:@"search_more"] forState:UIControlStateNormal];
    [_goMoreBtn setImage:[UIImage imageNamed:@"search_more"] forState:UIControlStateSelected];
    [self addSubview:_goMoreBtn];
    
    
    _goPageBtn = [[UIButton alloc]initWithFrame:CGRectMake(w*3, 0, w, self.height)];
    [_goPageBtn setImage:[UIImage imageNamed:@"search_page"] forState:UIControlStateNormal];
    [_goPageBtn setImage:[UIImage imageNamed:@"search_page"] forState:UIControlStateSelected];
    [self addSubview:_goPageBtn];
    
    
    _pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, self.height)];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = FONT12;
    _pageLabel.textColor = RGB(50, 50, 50);
    [_goPageBtn addSubview:_pageLabel];
    
    _pageLabel.text = [NSString stringWithFormat:@"%@",@(1)];
    
    
    _goHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(w*4, 0, w, self.height)];
    [_goHomeBtn setImage:[UIImage imageNamed:@"search_home"] forState:UIControlStateNormal];
    [_goHomeBtn setImage:[UIImage imageNamed:@"search_home"] forState:UIControlStateSelected];
    [self addSubview:_goHomeBtn];
    
    
    self.currentWebView = nil;
    
    
    [_goBackBtn addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    [_goForwardBtn addTarget:self action:@selector(goForwardAction) forControlEvents:UIControlEventTouchUpInside];
    [_goHomeBtn addTarget:self action:@selector(goHomeAction) forControlEvents:UIControlEventTouchUpInside];
    [_goPageBtn addTarget:self action:@selector(goPageAction) forControlEvents:UIControlEventTouchUpInside];
    [_goMoreBtn addTarget:self action:@selector(goMoreAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)setCurrentWebView:(WKWebView *)currentWebView {
    
    NSLog(@"_currentWebView = %@",_currentWebView);
    
    _currentWebView = currentWebView;
 
//    [_currentWebView removeObserver:self forKeyPath:@"URL"];
   
    [_currentWebView addObserver:self
                      forKeyPath:@"loading"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    [_currentWebView addObserver:self
                      forKeyPath:@"title"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    [_currentWebView addObserver:self
                   forKeyPath:@"URL"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    [_currentWebView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    _currentWebView.navigationDelegate = self;
    _currentWebView.UIDelegate = self;
    
    [self checkSearchStatus];
    
    
    
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    
    NSLog(@"decidePolicyForNavigationAction \ntitle = %@,url = %@",webView.title,webView.URL.absoluteString);
    
    NSURL *url = navigationAction.request.URL;
        
    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"]){
        
        NSLog(@"navigationAction = %@ ",url);
        
        [[UIApplication sharedApplication] openURL:url];
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }
 
 
    
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    
    NSLog(@"didStartProvisionalNavigation \ntitle = %@,url = %@",webView.title,webView.URL.absoluteString);
    
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    
    NSLog(@"didFailProvisionalNavigation ");
    
//    [[UIApplication sharedApplication] openURL:webView.URL];
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    // 禁止放大缩小
//    NSString *injectionJSString = @"var script = document.createElement('meta');"
//    "script.name = 'viewport';"
//    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
//    
//    
//    NSLog(@"didFinishNavigation \ntitle = %@,url = %@",webView.title,webView.URL.absoluteString);
    
    [self checkSearchStatus];
}



- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
//    [[UIApplication sharedApplication] openURL:webView.URL];
    
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation %@ ,%@",webView.title ,webView.URL.absoluteString);
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
 
    NSLog(@"didCommitNavigation %@ ,%@",webView.title ,webView.URL.absoluteString);
    
    
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary* )change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
        NSLog(@"loading");
        
    } else if ([keyPath isEqualToString:@"title"]) {
    
        NSLog(@"title  %@ == %@ %@",keyPath,change,self.currentWebView.URL.absoluteString);
        
        NSString *url = self.currentWebView.URL.absoluteString;
        NSString *title = change[@"new"];
        
        if(title.length > 0){
            
            BOOL isRecord = [[NSUserDefaults standardUserDefaults] boolForKey:@"wuheng"];
            
            if(isRecord == NO){
                
                [[RecordDataBase alloc] insertTableWithTitle:title url:url];
            }
        }
        
        [self.titleBtn setTitle:title forState:UIControlStateNormal];

        [self checkSearchStatus];
        
    }
    
    else if ( [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
     
        NSLog(@"newprogress = %@",@(newprogress));
        
        if(newprogress == 1){
            
            [self checkSearchStatus];
            self.line.hidden = YES;

        }
        else {
            
            self.line.hidden = NO;
            
            [self.currentWebViewVC.view addSubview:self.line];
            
            self.line.frame = CGRectMake(0, 0, SCREEM_WIDTH *newprogress, 2);
            
        }
    }
}


- (UILabel *)line {
    
    if(_line == nil){
        _line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 2)];
        _line.backgroundColor = [UIColor blueColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:_line];
        _line.hidden = YES;
    }
    
    return _line;
}


- (UIButton *)titleBtn {
    
    if(_titleBtn == nil){
        _titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height - SCREEM_HEIGHT, SCREEM_WIDTH, 40)];
        _titleBtn.titleLabel.font = FONT10;
        [_titleBtn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        [self addSubview:_titleBtn];
        [_titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
        _titleBtn.hidden = YES;
        
        BOOL isRecord = [[NSUserDefaults standardUserDefaults] boolForKey:@"wuheng"];
        
        if(isRecord == NO){
            
            _titleBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        }
        else {
            _titleBtn.backgroundColor = RGB(200, 200, 200);
        }
        
    }
    
    return _titleBtn;
}





- (void)checkSearchStatus {
    
    BOOL  canGoBack = [_currentWebView canGoBack];
    BOOL  canForward = [_currentWebView canGoForward];
    
    NSLog(@"goback = %@ , goForward = %@",@(canGoBack),@(canForward));
    
    if(self.currentWebViewVC.isHome == YES){
        
        _goBackBtn.selected = NO;
        _goBackBtn.userInteractionEnabled = NO;
        
        
        if(canForward == YES){
            _goForwardBtn.selected = YES;
            _goForwardBtn.userInteractionEnabled = YES;
        }
        else {
            
            _goForwardBtn.selected = NO;
            _goForwardBtn.userInteractionEnabled = NO;
        }
        
        
        return;
    }
    
    _goBackBtn.selected = YES;
    _goBackBtn.userInteractionEnabled = YES;
    
//    if(canGoBack == YES){
//        
//        _goBackBtn.selected = YES;
//        _goBackBtn.userInteractionEnabled = YES;
//    }
//    else {
//        _goBackBtn.selected = NO;
//        _goBackBtn.userInteractionEnabled = NO;
//    }
    
    
    if(canForward == YES){
        _goForwardBtn.selected = YES;
        _goForwardBtn.userInteractionEnabled = YES;
    }
    else {
        
        _goForwardBtn.selected = NO;
        _goForwardBtn.userInteractionEnabled = NO;
    }
}



- (void)goBackAction {
    
    BOOL  canGoBack = [_currentWebView canGoBack];
    
    if(canGoBack == YES){
        
        [_currentWebView goBack];
    }
    else {
        
        [self.currentWebViewVC showHomeView];
    }
    
    
//    [self checkSearchStatus];
}


- (void)goForwardAction {
    
    BOOL isHome = self.currentWebViewVC.isHome;

    
    if(isHome == YES){
        
        [self.currentWebViewVC showWebView];
    }
    else {
        
        [_currentWebView goForward];
    }
    
    
    
//    [self checkSearchStatus];
}


- (void)goMoreAction {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [WKPopView showInView:window success:^(NSInteger tag) {
        
        [self popActionWithTag:tag];
    }];
    
}

- (void)popActionWithTag:(NSInteger)tag {
    
    if(tag == 0){
        
        RecordViewController *nextVC = [[RecordViewController alloc]init];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [root presentViewController:navi animated:YES completion:nil];
        
    }
    else if (tag == 1){
        
        CollectViewController *nextVC = [[CollectViewController alloc]init];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [root presentViewController:navi animated:YES completion:nil];
    }
    else if (tag == 2){
        
        [self.currentWebView reload];
    }
    else if (tag == 3){
     
        [self shareAction];
    }
    else if (tag == 7){
        
        SettingsViewController *nextVC = [[SettingsViewController alloc]init];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [root presentViewController:navi animated:YES completion:nil];
        
    }
    else if (tag == 4){
        
        
        NSString *title = self.currentWebView.title;
        NSString *url = self.currentWebView.URL.absoluteString;
        
        if(title.length >0 && url.length >0){
            
            [[RecordDataBase alloc] insertCollWithTitle:title url:url ];
            
            [HUDManager alertText:@"收藏成功"];
        }
        
    }
}


- (void)shareAction {
    
    NSString * string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APPSTOREID];
    
    NSString *share_title = @"分享给你";
    NSString *share_url = string;
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[share_title,[NSURL URLWithString:share_url]] applicationActivities:nil];
    [self.currentWebViewVC presentViewController:avc animated:YES completion:nil];
}


- (void)goHomeAction {
    
    BOOL isHome = self.currentWebViewVC.isHome;
    
    NSLog(@"home");
    
    if(isHome == YES){
        return;
    }
        
//    [self.currentWebViewVC loadReqWithURL:@"http://about:blank"];
    
    [self.currentWebViewVC showHomeView];
    
    [self.currentWebViewVC.view addSubview:self];
    
//    [self.currentWebViewVC.navigationController popToRootViewControllerAnimated:YES];
    
    
    
    
}

- (void)goPageAction {
    
    
    WKBrowserViewController *nextVC = self.currentWebViewVC;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        nextVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        
    } completion:^(BOOL finished) {
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationAction" object:nil];
        
        
        nextVC.view.userInteractionEnabled = NO;
        [nextVC.view removeFromSuperview];
        [self removeFromSuperview];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    
}


- (void)countPageCount {
    
    NSInteger index = _pageArray.count;
    
    _pageLabel.text = [NSString stringWithFormat:@"%@",@(index)];
    
}









@end
