//
//  DHeadView.m
//  KKWeb
//
//  Created by 李加建 on 2017/11/22.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DHeadView.h"

@implementation DHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatBtn];
    
    return self;
}




- (void)creatBtn {
    
    CGFloat w = self.frame.size.width;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(w/2 - 30, 20, 60, 44)];
    //    btn.backgroundColor = [UIColor redColor];
    [btn setImage:[UIImage imageNamed:@"root_add"] forState:UIControlStateNormal];
    [self addSubview:btn];
    
//    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(w - 60, 20, 60, 44)];
    //    btn1.backgroundColor = [UIColor redColor];
    [btn1 setImage:[UIImage imageNamed:@"root_back"] forState:UIControlStateNormal];
    [self addSubview:btn1];
    
//    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    
    self.addBtn = btn;
    self.backBtn = btn1;
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    //    btn.backgroundColor = [UIColor redColor];
    [btn3 setImage:[UIImage imageNamed:@"root_mul"] forState:UIControlStateNormal];
    [self addSubview:btn3];
    self.delBtn = btn3;
}





@end
