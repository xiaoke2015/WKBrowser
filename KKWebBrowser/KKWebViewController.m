//
//  KKWebViewController.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKWebViewController.h"

#import <WebKit/WebKit.h>

#import "KWebBarView.h"

#import "RecordDataBase.h"

@interface KKWebViewController () <WKNavigationDelegate ,WKUIDelegate>

@property (nonatomic ,strong)WKWebView *webView;

@property (nonatomic ,strong)UILabel *line;

@property (nonatomic ,strong)KWebBarView *headView;

@end

@implementation KKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatWebView];
    
    [self initHeadView];
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



- (void)initHeadView {
    
    _headView = [[KWebBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 64)];
    
    [self.view addSubview:_headView];
    
    __weak typeof(self) weak = self;
    
    _headView.reloadWebBlock = ^{
        
//        [weak loadReqWithURL:weak.model.url];
        
        [weak.webView reload];
    };
    
    
    _headView.delloadWebBlock = ^{
        
        [weak.webView stopLoading];
    };
}



- (void)loadReqWithURL:(NSString *)url {
    
    //    url = @"http://wap.baidu.com";
    
    NSURLRequest *req = [[NSURLRequest  alloc]initWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:req];
    
    [self.view addSubview:self.webView];
    
}



- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if(animated == NO){
        
        [_webView removeObserver:self forKeyPath:@"loading"];
        [_webView removeObserver:self forKeyPath:@"title"];
        [_webView removeObserver:self forKeyPath:@"URL"];
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
        
        _webView.navigationDelegate = nil;
        _webView.UIDelegate = nil;
    }
    
    
}



- (void)creatWebView {
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEM_WIDTH, SCREEM_HEIGHT - 64 - 44)];
    
    
    [self.view addSubview:_webView];
    
    
    [_webView addObserver:self
                      forKeyPath:@"loading"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    [_webView addObserver:self
                      forKeyPath:@"title"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    [_webView addObserver:self
                      forKeyPath:@"URL"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    [_webView addObserver:self
                      forKeyPath:@"estimatedProgress"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    
    [self loadReqWithURL:self.model.url];
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
    
//    decisionHandler(WKNavigationResponsePolicyCancel);
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
        
//        NSLog(@"title  %@ == %@ %@",keyPath,change,self.currentWebView.URL.absoluteString);
        
        NSString *url = self.webView.URL.absoluteString;
        
        NSString *title = change[@"new"];
        
        _headView.textField.text = title;
        
        if(title.length > 0){
            
            BOOL isRecord = [[NSUserDefaults standardUserDefaults] boolForKey:@"wuheng"];
            
            if(isRecord == NO){
                
                [[RecordDataBase alloc] insertTableWithTitle:title url:url];
            }
            
            self.model.changeUrl = url;
            self.model.changeTitle = title;
        }
        
//        [self.titleBtn setTitle:title forState:UIControlStateNormal];
        
        [self checkSearchStatus];
        
    }
    
    else if ( [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        
        NSLog(@"newprogress = %@",@(newprogress));
        
        if(newprogress == 1){
            
            [self checkSearchStatus];
            self.line.hidden = YES;
            
            _headView.rightBtn.selected = NO;
    
        }
        else {
            
            self.line.hidden = NO;
            
            [self.webView addSubview:self.line];
            
            self.line.frame = CGRectMake(0, 0, SCREEM_WIDTH *newprogress, 2);
            
            _headView.rightBtn.selected = YES;
            
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



- (void)checkSearchStatus {
    
    BOOL  canGoBack = [_webView canGoBack];
    BOOL  canForward = [_webView canGoForward];
    
    KKBootBarView *barView = [KKBootBarView shareInstance];
    
    barView.webView = self.webView;
 
    barView.goBackBtn.selected = canGoBack;
    barView.goForwardBtn.selected = canForward;
    
    barView.goHomeBtn.selected = YES;
    
}


@end
