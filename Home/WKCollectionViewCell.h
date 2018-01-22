//
//  WKCollectionViewCell.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong)UIView *bgView;

@property (nonatomic ,copy)ActionBlock goBlock;

@property (nonatomic ,strong)UILabel *label;

@end
