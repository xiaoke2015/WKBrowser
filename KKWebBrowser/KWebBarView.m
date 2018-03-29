//
//  KWebBarView.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KWebBarView.h"

@implementation KWebBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = RGB(240, 240, 240);
    
    [self creatView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bottom - 0.5, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line];
    
    return self;
}



- (void)creatView {
    
    CGFloat h = 30;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 27, SCREEM_WIDTH - 30, h)];
    
    textField.placeholder = @"搜索或输入网址";
    textField.backgroundColor = RGBA(255, 255, 255, 0.6);
    //    textField.alpha = 0.6;
    textField.textColor = RGBA(128, 128, 128, 1);
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 4;
    textField.font = FONT(14);
    
    
    textField.keyboardType = UIKeyboardTypeWebSearch;
    textField.returnKeyType = UIReturnKeySearch;
    textField.delegate = self;
    
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [textField setValue:RGBA(128, 128, 128, 0.9) forKeyPath:@"_placeholderLabel.textColor"];
    
    self.textField = textField;
    [self.textField setEnabled:NO];
    
    [self addSubview:textField];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, h, h)];
    [leftBtn setImage:[UIImage imageNamed:@"root_search"] forState:UIControlStateNormal];
    textField.leftView = leftBtn;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, h, h)];
    //    rightBtn.backgroundColor = [UIColor redColor];
    
    textField.rightView = rightBtn;
    textField.rightViewMode = UITextFieldViewModeAlways;
    [rightBtn setImage:[UIImage imageNamed:@"root_refresh"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"root_close"] forState:UIControlStateSelected];
    
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBtn = rightBtn;
    
}



- (void)leftBtnAction {
    
    
}


- (void)rightBtnAction:(UIButton*)btn {
    

    if(btn.selected == NO){
        
        if(_reloadWebBlock != nil){
            _reloadWebBlock();
        }
    }
    else {
        
        if(_delloadWebBlock != nil){
            _delloadWebBlock();
        }
    }
    
}


@end
