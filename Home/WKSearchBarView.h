//
//  WKSearchBarView.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/6.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

#import "WKBrowserViewController.h"

#import <SafariServices/SafariServices.h>

#import "WKRootViewController.h"


#define CWidth (SCREEM_WIDTH*0.8)
#define CHeight (300)


@interface WKSearchBarView : UIView

@property (nonatomic ,strong)WKWebView *currentWebView;

@property (nonatomic ,strong)NSMutableArray * pageArray;

@property (nonatomic ,strong)NSMutableArray * delArray;

@property (nonatomic ,strong)WKBrowserViewController *currentWebViewVC;

@property (nonatomic ,strong)UICollectionView *collectionView;

@property (nonatomic ,strong)WKRootViewController *rootVC;

@property (nonatomic ,strong)UIButton * titleBtn;
@property (nonatomic ,strong)UILabel * line;


@property (nonatomic ,strong)NSString * city;
@property (nonatomic ,assign)double  lat;
@property (nonatomic ,assign)double  lng;



+ (WKSearchBarView *)shareInstance ;

- (void)countPageCount ;

- (void)addPage ;


- (void)checkSearchStatus ;



@end
