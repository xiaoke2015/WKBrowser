//
//  WKRootViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/6.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WKRootViewController.h"

#import "WKSearchBarView.h"

#import "XLCardSwitch.h"

#import "WKCollectionViewCell.h"

#import "CardBrowserFlatLayout.h"

#import "XLCardSwitchFlowLayout.h"

#import "DWebCardView.h"

#import "CardsViewController.h"

@interface WKRootViewController ()

@property (nonatomic ,strong)CardsViewController * cardsVC;

@end

@implementation WKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBA(25, 25, 25, 0.9);
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
        
    searchBarView.currentWebViewVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    
    [self.view addSubview:searchBarView.currentWebViewVC.view];
    
    [searchBarView.currentWebViewVC.view addSubview:searchBarView];
    
    searchBarView.currentWebViewVC = searchBarView.currentWebViewVC;
    searchBarView.currentWebView = searchBarView.currentWebViewVC.webView;
    
    searchBarView.rootVC = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction) name:@"notificationAction" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selPageAction) name:@"selpageactopn" object:nil];
    
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


- (CardsViewController *)cardsVC {
    
    if(_cardsVC == nil){
        
        _cardsVC = [[CardsViewController alloc]init];
    }
    
    return _cardsVC;
}


- (void)selPageAction {
    
    [self selectView];
}



- (void)notificationAction {
    


    CardsViewController * nextVC = [[CardsViewController alloc]init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self presentViewController:nextVC animated:NO completion:nil];
    });
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    
    WKBrowserViewController *nextVC = searchBarView.pageArray[indexPath.row];
    
    searchBarView.currentWebViewVC = nextVC ;
    searchBarView.currentWebView = nextVC.webView;
    
    searchBarView.titleBtn.hidden = nextVC.isHome;
    
    [self selectView];
}


- (void)selectView {
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    
    WKBrowserViewController *nextVC = searchBarView.currentWebViewVC;
    
    [self.view addSubview:searchBarView.currentWebViewVC.view];
    
    searchBarView.titleBtn.hidden = nextVC.isHome;

    
    CGFloat w = nextVC.view.width;
    CGFloat h = nextVC.view.height;
    
    nextVC.view.frame = CGRectMake(SCREEM_WIDTH/2 - w/2, SCREEM_HEIGHT/2 - h/2, nextVC.view.width, nextVC.view.height);

    [UIView animateWithDuration:0.3 animations:^{
        
        searchBarView.currentWebViewVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
       
        searchBarView.currentWebViewVC.view.userInteractionEnabled = YES;
        
        [nextVC.view addSubview:searchBarView];
        
        [searchBarView countPageCount];
        
        
        BOOL isHome = nextVC.isHome;
        
        if(isHome == YES){
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

        }
        else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
   
        }
        
    }];
    
}



@end
