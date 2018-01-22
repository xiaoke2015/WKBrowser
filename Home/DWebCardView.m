//
//  DWebCardView.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/8.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DWebCardView.h"

#import "DWebCardFlowLayout.h"
#import "DWebCollectionViewCell.h"

@interface DWebCardView ()<UICollectionViewDelegate,UICollectionViewDataSource>
  
@property (nonatomic ,assign)CGFloat dragStartX;
@property (nonatomic ,assign)CGFloat dragEndX;


@end


@implementation DWebCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    [self addCollectionView];
}

- (void)addCollectionView {
    //避免UINavigation对UIScrollView产生的便宜问题
    [self addSubview:[UIView new]];
    
    
    DWebCardFlowLayout *flowLayout = [[DWebCardFlowLayout alloc] init];
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[DWebCollectionViewCell class] forCellWithReuseIdentifier:@"DWebCollectionViewCell"];
    _collectionView.userInteractionEnabled = true;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}

#pragma mark -
#pragma mark Setter
-(void)setItems:(NSMutableArray<WKBrowserViewController *> *)items {
    _items = items;
    [_collectionView reloadData];
}

#pragma mark -
#pragma mark CollectionDelegate
//配置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _selectedIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _selectedIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    
    [self scrollToCenter2];
}

//滚动到中间
- (void)scrollToCenter {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self performDelegateMethod];
}

- (void)scrollToCenter2 {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    //    [self performDelegateMethod];
}




#pragma mark -
#pragma mark CollectionDelegate
//在不使用分页滚动的情况下需要手动计算当前选中位置 -> _selectedIndex
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pagingEnabled) {return;}
    if (!_collectionView.visibleCells.count) {return;}
    if (!scrollView.isDragging) {return;}
    CGRect currentRect = _collectionView.bounds;
    currentRect.origin.x = _collectionView.contentOffset.x;
    
    
    for (DWebCollectionViewCell *card in _collectionView.visibleCells) {
        if (CGRectContainsRect(currentRect, card.frame)) {
            NSInteger index = [_collectionView indexPathForCell:card].row;
            if (index != _selectedIndex) {
                _selectedIndex = index;
            }
        }
    }
}

//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!_pagingEnabled) {return;}
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    
    [self scrollToCenter];
    
    NSLog(@"scrollToCenter");
}

#pragma mark -
#pragma mark CollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"DWebCollectionViewCell";
    DWebCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    WKBrowserViewController *nextVC = _items[indexPath.row];;
    
    cell.item = nextVC;
    
    cell.goBlock = ^{
        
        
        WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
        
        //添加删除数据 保存内存
        [searchBarView.delArray addObject:nextVC];
        
        [searchBarView.pageArray removeObject:nextVC];
        
        if(searchBarView.pageArray.count <= 0){
            
            [searchBarView addPage];
        }
        
//        [self.collectionView reloadData];
        
        [self setItems:searchBarView.pageArray];
        
    
    };
    
    
    return  cell;
}

#pragma mark -
#pragma mark 功能方法

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self switchToIndex:selectedIndex animated:false];
}

- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated {
    _selectedIndex = index;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    [self performDelegateMethod];
}

- (void)performDelegateMethod {
    
    if ([_delegate respondsToSelector:@selector(XLCardSwitchDidSelectedAt:)]) {
        [_delegate XLCardSwitchDidSelectedAt:_selectedIndex];
    }
}



- (void)reloadView {
    
    
    [_collectionView reloadData];
}



@end
