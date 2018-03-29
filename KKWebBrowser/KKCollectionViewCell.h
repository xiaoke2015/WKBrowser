//
//  KKCollectionViewCell.h
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KKFlowLayout.h"

#import "ItemModel.h"

@interface KKCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong)ItemModel *model;

@end
