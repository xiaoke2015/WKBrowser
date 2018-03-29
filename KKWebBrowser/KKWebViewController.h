//
//  KKWebViewController.h
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <JKBaseKit/JKBaseKit.h>

#import "ItemModel.h"

@interface KKWebViewController : JKBaseViewController

@property (nonatomic ,strong)ItemModel *model;

- (void)checkSearchStatus ;

@end
