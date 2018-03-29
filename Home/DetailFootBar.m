//
//  DetailFootBar.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DetailFootBar.h"

@implementation DetailFootBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.width, 0.5);
    layer.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, self.height/2 - 15, self.width - 90, 30)];
    
    btn.backgroundColor = RGB(240, 240, 240);
    btn.layer.cornerRadius = btn.height/2;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"写评论" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 60, self.height/2 - 15, 50, 30)];
    
    [self addSubview:btn2];
    
    [btn2 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"like_fill"] forState:UIControlStateSelected];
    
    [btn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = btn2;
}



- (void)btnAction {
    
 
    if(_commentBlock != nil){
        _commentBlock();
    }
    
}



- (void)btn2Action:(UIButton*)btn {
    
//    btn.selected = !btn.selected;
    
    if(btn.selected == YES){
        if(_delCollBlock != nil){
            _delCollBlock();
        }
    }
    else {
        if(_addCollBlock != nil){
            _addCollBlock();
        }
    }
}


@end
