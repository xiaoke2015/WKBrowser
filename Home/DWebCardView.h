//
//  DWebCardView.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/8.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DWebCardItem.h"

#import "WKBrowserViewController.h"

@protocol DWCardSwitchDelegate <NSObject>

@optional

/**
 滚动代理方法
 */
-(void)XLCardSwitchDidSelectedAt:(NSInteger)index;

-(void)XLCardSwitchDidScrollAt:(NSInteger)index;

@end


@interface DWebCardView : UIView


@property (nonatomic ,strong)UICollectionView *collectionView;

/**
 当前选中位置
 */
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
/**
 设置数据源
 */
@property (nonatomic, strong) NSMutableArray <WKBrowserViewController *>*items;
/**
 代理
 */
@property (nonatomic, weak)  id<DWCardSwitchDelegate>delegate;

/**
 是否分页，默认为true
 */
@property (nonatomic, assign) BOOL pagingEnabled;

/**
 手动滚动到某个卡片位置
 */
- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated;


- (void)reloadView ;


@end
