//
//  DetailFootBar.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSCommentModel.h"

@interface DetailFootBar : UIView

@property(nonatomic ,strong)UIButton *btn2;

@property (nonatomic ,copy)ActionBlock commentBlock;
@property (nonatomic ,copy)ActionBlock delCollBlock;
@property (nonatomic ,copy)ActionBlock addCollBlock;

@end
