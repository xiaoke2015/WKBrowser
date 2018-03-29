//
//  AlphaView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "AlphaView.h"


@interface AlphaView ()

@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,strong)UILabel *line;

@end

@implementation AlphaView

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
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    [self addSubview:_bgView];
    
    
    _line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    _line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:_line];
    
    _line.hidden = YES;
}



- (void)scrollWithY:(CGFloat)y {
    
    NSLog(@"yyyyy %@",@(y));
    
    if(y > 0){
        _bgView.alpha = y/64.f;
        _bgView.backgroundColor = MAINCOLOR;
        _line.hidden = YES;
        
        if(y >= 64){
            _line.hidden = NO;
        }
        
    }
    else {
        _bgView.alpha = y/-128.f;
        _bgView.backgroundColor = RGB(220, 220, 220);
        _line.hidden = YES;
    }
}


@end
