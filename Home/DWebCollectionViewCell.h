//
//  DWebCollectionViewCell.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/8.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DWebCardItem.h"

@interface DWebCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong)UIButton *btn;

@property (nonatomic ,strong)UIView *bgView;

@property (nonatomic ,copy)ActionBlock goBlock;

@property (nonatomic ,strong)UILabel *label;


@property (nonatomic, strong) WKBrowserViewController *item;

@end
