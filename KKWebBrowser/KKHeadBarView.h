//
//  KKHeadBarView.h
//  KKWeb
//
//  Created by 李加建 on 2017/11/22.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapURLBlock)(NSString *url);

@interface KKHeadBarView : UIView <UITextFieldDelegate>

@property (nonatomic ,strong)UITextField *textField;

@property (nonatomic ,copy)TapURLBlock tapURLBlock;

@property (nonatomic ,copy)ActionBlock qrCodeBlock;

+ (KKHeadBarView*)shareInstance ;

@end
