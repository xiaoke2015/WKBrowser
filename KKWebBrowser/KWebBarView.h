//
//  KWebBarView.h
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KWebBarView : UIView <UITextFieldDelegate>

@property (nonatomic ,strong)UITextField *textField;

@property (nonatomic ,strong)UIButton *rightBtn;

@property (nonatomic ,copy)ActionBlock reloadWebBlock;

@property (nonatomic ,copy)ActionBlock delloadWebBlock;

@end
