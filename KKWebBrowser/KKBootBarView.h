//
//  KKBootBarView.h
//  KKWeb
//
//  Created by 李加建 on 2017/11/22.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>

@interface KKBootBarView : UIView

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

@property (nonatomic ,strong)WKWebView * webView;

//页面数量
@property (nonatomic ,strong)UILabel * pageLabel;

+ (KKBootBarView*)shareInstance ;



@end
