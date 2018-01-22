//
//  WKHomeViewController.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^TapURLBlock)(NSString *url);

@interface WKHomeViewController : UIViewController

@property (nonatomic ,copy)TapURLBlock tapURLBlock;

@end
