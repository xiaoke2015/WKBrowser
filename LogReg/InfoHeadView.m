//
//  InfoHeadView.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoHeadView.h"

#import "IconButton.h"

@interface InfoHeadView ()

@property (nonatomic ,strong)UIView *bgView ;

@property (nonatomic ,strong)NSMutableArray *btnsArray;

@end

@implementation InfoHeadView

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



- (void)imgTap {
    
    if(_goBlock1 != nil){
        _goBlock1();
    }
}


- (void)creatView {
    
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 200)];
    _bgView.backgroundColor = MAINCOLOR;
    [self addSubview:_bgView];
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 200)];
    bgImgView.image = [UIImage imageNamed:@"avatar_bg.jpg"];
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    bgImgView.clipsToBounds = YES;
    [_bgView addSubview:bgImgView];
    
    UIView * circleView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 73, 73)];
    circleView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:circleView];
    circleView.layer.masksToBounds = YES;
    circleView.layer.cornerRadius = circleView.height/2;
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
    _imgView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_imgView];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.height/2;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    
    _imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap)];
    
    [_imgView addGestureRecognizer:tap];
    
    
    _imgView.image = [UIImage imageNamed:@"avatar"];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(90, 30, self.width - 100, 30)];
    _name.font = FONT20;
    _name.textColor = [UIColor whiteColor];
    [_bgView addSubview:_name];
    _name.textAlignment = NSTextAlignmentCenter;
    
    _imgView.center = CGPointMake(_bgView.center.x, _bgView.center.y + 10);
    circleView.center = _imgView.center;
    
    CGFloat h = _bgView.height - _imgView.bottom;
    
    _name.frame = CGRectMake(0, _imgView.bottom, self.width, h);
    
    _name.text = @"未登录";
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _bgView.height + 0, SCREEM_WIDTH, 10)];
//    line.backgroundColor = RGB(240, 240, 240);
//    
//    [self addSubview:line];
    
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _bgView.height);
    
}



- (void)btnAction:(IconButton*)btn {
    
    NSInteger tag = [_btnsArray indexOfObject:btn];
    
    if(_goBlock != nil){
        _goBlock(tag);
    }
}



- (void)dataWithModel {
    
    
    
}


@end
