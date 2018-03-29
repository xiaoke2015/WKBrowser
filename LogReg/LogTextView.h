//
//  LogTextView.h
//  DongJie
//
//  Created by yuyue on 2017/6/23.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogTextView : UIButton

@property (nonatomic ,strong)UITextField * textField ;

// 输入框初始化
- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder ;


// 按钮初始化
- (instancetype)initWithFrame:(CGRect)frame;

@end
