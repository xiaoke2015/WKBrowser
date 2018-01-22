//
//  WKPopView.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PopSelTag)(NSInteger tag);

@interface WKPopView : UIView




+ (void)showInView:(UIView*)view  success:(PopSelTag)success ;

@end
