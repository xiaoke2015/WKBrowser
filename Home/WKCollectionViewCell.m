//
//  WKCollectionViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WKCollectionViewCell.h"

@interface WKCollectionViewCell ()


@property (nonatomic ,strong)UIButton *btn;

@end

@implementation WKCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 30)];
    bgView.backgroundColor = RGB(240, 240, 240);
    
    [self.contentView addSubview:bgView];
    
    self.bgView = bgView;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.width - 50, 30)];
    _label.font = FONT14;
    [bgView addSubview:_label];
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 30, 0, 30, 30)];
//    _btn.backgroundColor = [UIColor orangeColor];
    [_btn setImage:[UIImage imageNamed:@"root_del"] forState:UIControlStateNormal];
    [bgView addSubview:_btn];
    
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)btnAction {
    
    if(_goBlock != nil){
        _goBlock();
    }
}

@end
