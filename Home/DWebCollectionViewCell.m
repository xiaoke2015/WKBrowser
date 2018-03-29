//
//  DWebCollectionViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/8.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DWebCollectionViewCell.h"

@implementation DWebCollectionViewCell




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

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSLog(@" frame=== %@",self);
    
    
}


- (void)setItem:(WKBrowserViewController *)item {
    
    //    _imageView.image = [UIImage imageNamed:item.imageName];
    //    _textLabel.text = item.title;
    
    //    [_imageView sd_setImageWithURL:[NSURL URLWithString:item.imageName]];
    
    //    [self.contentView addSubview:item.pageVC.view];
    
    
    NSLog(@"width %@ ,height %@",@(item.view.width) ,@(item.view.height));
    
//    CGFloat scalex = self.width/SCREEM_WIDTH;
//    CGFloat scaley = self.height/SCREEM_HEIGHT;
    
    
    item.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
    
    [self.contentView addSubview:item.view];
    
    [self.contentView insertSubview:item.view belowSubview:self.bgView];
    
    item.view.center = self.contentView.center;
//    item.view.frame = CGRectMake(0, 0, item.view.width, item.view.height);
    item.view.userInteractionEnabled = NO;
    self.contentView.clipsToBounds = YES;
    
    
    self.label.text = item.isHome == YES ? @"首页":item.webView.title;
}

@end
