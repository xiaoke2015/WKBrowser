//
//  KKCollectionViewCell.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKCollectionViewCell.h"


@interface KKCollectionViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *title;

@end

@implementation KKCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.width*0.2, self.width*0.2, self.width*0.6, self.width*0.6)];
    
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 4;
    [self addSubview:_imgView];
    
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.width *0.9, self.width, 20)];
    
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = FONT(11);
    [self addSubview:_title];
}




- (void)setModel:(ItemModel *)model {
    
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    
    _title.text = model.title;
}



@end
