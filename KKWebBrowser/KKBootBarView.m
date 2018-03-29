//
//  KKBootBarView.m
//  KKWeb
//
//  Created by 李加建 on 2017/11/22.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKBootBarView.h"



@interface KKBootBarView ()





@end

@implementation KKBootBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (KKBootBarView*)shareInstance {
    
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    static KKBootBarView *testa = nil;
    static dispatch_once_t once_t;
    
    dispatch_once(&once_t, ^{
        
        testa = [[KKBootBarView alloc]initWithFrame:CGRectMake(0, rect.size.height - 44, rect.size.width, 44)];
    });
    
    return testa;
    
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatBtns];
    
    return self;
}


- (void)creatBtns {
    
    CGFloat w = self.frame.size.width/5;
    
    CGFloat h = self.frame.size.height;
    
    _goBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    [_goBackBtn setImage:[UIImage imageNamed:@"search_back_n"] forState:UIControlStateNormal];
    [_goBackBtn setImage:[UIImage imageNamed:@"search_back_s"] forState:UIControlStateSelected];
    [self addSubview:_goBackBtn];
    
    
    _goForwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(w, 0, w, h)];
    [_goForwardBtn setImage:[UIImage imageNamed:@"search_forward_n"] forState:UIControlStateNormal];
    [_goForwardBtn setImage:[UIImage imageNamed:@"search_forward_s"] forState:UIControlStateSelected];
    [self addSubview:_goForwardBtn];
    
    
    _goMoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(w*4, 0, w, h)];
    [_goMoreBtn setImage:[UIImage imageNamed:@"search_more"] forState:UIControlStateNormal];
    [_goMoreBtn setImage:[UIImage imageNamed:@"search_more"] forState:UIControlStateSelected];
    [self addSubview:_goMoreBtn];
    
    
    _goPageBtn = [[UIButton alloc]initWithFrame:CGRectMake(w*3, 0, w, h)];
    [_goPageBtn setImage:[UIImage imageNamed:@"search_page"] forState:UIControlStateNormal];
    [_goPageBtn setImage:[UIImage imageNamed:@"search_page"] forState:UIControlStateSelected];
    [self addSubview:_goPageBtn];
    

    _goHomeBtn = [[UIButton alloc]initWithFrame:CGRectMake(w*2, 0, w, h)];
    [_goHomeBtn setImage:[UIImage imageNamed:@"search_home_n"] forState:UIControlStateNormal];
    [_goHomeBtn setImage:[UIImage imageNamed:@"search_home"] forState:UIControlStateSelected];
    [self addSubview:_goHomeBtn];
    
    
    
    [_goBackBtn addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [_goForwardBtn addTarget:self action:@selector(goForwardAction:) forControlEvents:UIControlEventTouchUpInside];
    [_goHomeBtn addTarget:self action:@selector(goHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_goPageBtn addTarget:self action:@selector(goPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_goMoreBtn addTarget:self action:@selector(goMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line];
    
    
    _pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(-2, -self.height*0.07, w, self.height)];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = FONT(10);
    _pageLabel.textColor = RGB(50, 50, 50);
    [_goPageBtn addSubview:_pageLabel];
    
    _pageLabel.text = [NSString stringWithFormat:@"%@",@(1)];
    
}



- (void)goBackAction:(UIButton*)btn {
    
    if(btn.selected == YES){
    
        NSLog(@"goBackAction");
        
        [_webView goBack];
    }
}

- (void)goForwardAction:(UIButton*)btn {
    
    if(btn.selected == YES){
        
        NSLog(@"goForwardAction");
        
        [_webView goForward];
    }
}

- (void)goHomeAction:(UIButton*)btn {
 
    if(btn.selected == YES){
        
        NSLog(@"goHomeAction");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gohomeaction" object:nil];
        
    }
}

- (void)goPageAction:(UIButton*)btn {
    
    NSLog(@"goPageAction");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addwebpage" object:nil];
}

- (void)goMoreAction:(UIButton*)btn {
    
    
    NSLog(@"goMoreAction");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreaction" object:nil];
}


@end
