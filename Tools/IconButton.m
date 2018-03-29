//
//  IconButton.m
//  Convertor
//
//  Created by 李加建 on 2017/9/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "IconButton.h"

@implementation IconButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat w = self.height/2;
    CGFloat h = self.height*0.2;
    CGFloat y = self.height/2 - w/2;
    CGFloat x = self.width/2 - w/2;
    
    self.titleRect = CGRectMake(0, y+w, self.width, h);
    self.imageRect = CGRectMake(x, y - h/2, w, w);
    
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 10;
    
    return self;
}




- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return self.titleRect;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return self.imageRect;
}


@end
