//
//  WKPopView.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WKPopView.h"

#import "IconButton.h"


@interface WKPopView ()

@property (nonatomic ,strong)UIView *customView;

@property (nonatomic ,strong)NSMutableArray *btnsArray;

@property (nonatomic ,copy)PopSelTag popSelBlock;

@end


@implementation WKPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (void)showInView:(UIView*)view  success:(PopSelTag)success {
    
    WKPopView * popView = [[WKPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    popView.popSelBlock  = success;
    [view addSubview:popView];
    
    
    
    
    [popView show];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)bgTapAction {
    
    [self hide];
}

- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapAction)];
    
    [bgView addGestureRecognizer:tap];
    
    
    CGFloat w = SCREEM_WIDTH/2;
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEM_HEIGHT, SCREEM_WIDTH - 60, w + 60)];
    

    
    _customView.backgroundColor = RGB(250, 250, 250);
    [self addSubview:_customView];
    
    _customView.layer.masksToBounds = YES;
    _customView.layer.cornerRadius = 10;
    
    [self addCustomView];
}



- (void)addCustomView {
    
    NSArray *array = @[@"历史记录",@"收藏列表",@"刷新",@"分享",@"添加收藏",@"设置"];
    
    _btnsArray = [NSMutableArray array];
    
    CGFloat w = _customView.width/4;
    
    for(int i=0;i<array.count;i++){
        
        
        IconButton *btn = [[IconButton alloc]initWithFrame:CGRectMake(w * (i%4), 20+w*(i/4), w, w)];
        
        [_customView addSubview:btn];
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        NSString *imgName = [NSString stringWithFormat:@"pop_btn_00%@",@(i+1)];
        
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        
        [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        btn.titleLabel.font = FONT12;
        
        [btn setImageRect:CGRectMake(btn.width/2 - 12, btn.height/2 - 25, 24, 24)];
     
        [btn setTitleRect:CGRectMake(0, btn.height/2 + 5, btn.width, 20)];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnsArray addObject:btn];
    }
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, _customView.height - 60, _customView.width, 30)];
    [btn2 setImage:[UIImage imageNamed:@"search_back_s"] forState:UIControlStateNormal];
    [_customView addSubview:btn2];
    
    btn2.imageView.transform = CGAffineTransformMakeRotation(-90*M_PI/180);
    
    [btn2 addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction:(IconButton*)btn {
    
    NSInteger index = [_btnsArray indexOfObject:btn];
    
    if(_popSelBlock != nil){
        
        _popSelBlock(index);
    }
    
    [self hide];
}



- (void)show {
    
    CGFloat x = 0;
    if(kDevice_Is_iPhoneX){
        x = 34;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(_customView.left, SCREEM_HEIGHT - _customView.height - x, _customView.width, _customView.height - 20);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(_customView.left, SCREEM_HEIGHT, _customView.width, _customView.height + 20);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


@end
