//
//  LogTextView.m
//  DongJie
//
//  Created by yuyue on 2017/6/23.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "LogTextView.h"

@implementation LogTextView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    
    self = [self initWithFrame:frame];

    CGFloat h = CGRectGetHeight(frame);
    CGFloat w = CGRectGetWidth(frame);
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(h/2, 0, w-h, h)];
    _textField.placeholder = placeholder;
    _textField.font = FONT14;
    [self addSubview:_textField];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = GRAY200.CGColor;
    
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self setup];
    
    return self;
}



- (void)setup {
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = self.height/2;
    
}



@end
