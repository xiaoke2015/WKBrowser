//
//  WKWebViewController.m
//  AiShang
//
//  Created by yuyue on 16/12/2.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import "WKWebViewController.h"

#import <WebKit/WebKit.h>

@interface WKWebViewController ()

@property (nonatomic,strong)UILabel *progress;

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)WKWebView *webView;

@property (nonatomic,strong)NSString *url;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma detail 设置偏移量
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    [self initNaviBarBtn:self.name];
    
    
    
    [self initWebView];
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



+ (void)pushVC:(UIViewController *)vc title:(NSString*)title URL:(NSString*)url {
    
    WKWebViewController *nextVC = [[WKWebViewController alloc]init];
    nextVC.name = title;
    nextVC.url = url;
    nextVC.hidesBottomBarWhenPushed = YES;
    [vc.navigationController pushViewController:nextVC animated:YES];
    
}



- (void)initWebView {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 20)];
    label.text = @"网页由";
    [self.view addSubview:label];
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
    
    [self.view addSubview:_webView];
    
//    [_webView setOpaque:NO];

    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url]];
    
    [_webView loadRequest:request];
    
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    _progress = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 2)];
    _progress.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_progress];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    
    
}


- (void)dealloc {
    
    
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary* )change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
    } else if ([keyPath isEqualToString:@"title"]) {
        //        self.title = self.wKWebView.title;
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        //        self.progressView.progress = self.wKWebView.estimatedProgress;
    }
    
    if ( [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            _progress.hidden = YES;
            _progress.frame = CGRectMake(0, 0, 0, 2);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }else {
            
            [UIView animateWithDuration:0.1 animations:^{
                
                _progress.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) * newprogress, 2);
            }];
        }
        
        NSLog(@"%@",@(newprogress));
        
        
        
    }
}



@end
