//
//  KKFlowLayout.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKFlowLayout.h"

@implementation KKFlowLayout




- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical ;
   
}

- (CGSize)collectionViewContentSize {
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    NSInteger count = 5;
    
    CGFloat w = 50;
    CGFloat h = w+20;
    CGFloat y = 44 + (h)*(cellCount / count + 1);
    
    return CGSizeMake(SCREEM_WIDTH, y);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
  
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    NSInteger count = 5;
    
    CGFloat w = 50;
    CGFloat h = w+20;
    
    CGFloat x1 = 20;
    
    CGFloat x = (SCREEM_WIDTH - w*count - x1*2)/4;
    
    attributes.frame = CGRectMake(x1 + (x+w)*(indexPath.row %count), 44 + (h)*(indexPath.row / count), w, h);
    
    return attributes;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}


@end
