//
//  KKHeadBarView.m
//  KKWeb
//
//  Created by 李加建 on 2017/11/22.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKHeadBarView.h"

#import "SGQRCodeScanningVC.h"

@implementation KKHeadBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (KKHeadBarView*)shareInstance {
    
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    static KKHeadBarView *testa = nil;
    static dispatch_once_t once_t;
    
    dispatch_once(&once_t, ^{
        
        testa = [[KKHeadBarView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 64)];
    });
    
    return testa;
    
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self creatView];
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bottom - 0.5, SCREEM_WIDTH, 0.5)];
//    line.backgroundColor = RGB(200, 200, 200);
//    [self addSubview:line];
    
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
    [rightBtn setImage:[UIImage imageNamed:@"root_qrcode"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    

}



- (void)leftBtnAction {
    
    
}


- (void)rightBtnAction {
    
//    if(_qrCodeBlock != nil){
//        _qrCodeBlock();
//    }
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        SGQRCodeScanningVC *nextVC = [[SGQRCodeScanningVC alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        
        [nextVC setScanSuccess:^(NSString *scanString){
                        
            if(_tapURLBlock != nil){
                _tapURLBlock(scanString);
            }
        }];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        [root presentViewController:navi animated:YES completion:nil];
        
    }else {
        NSLog(@"无相机");
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"Return");
    
    [self searchWithWords:textField.text];
    
    if ([textField returnKeyType] != UIReturnKeyDone) {
        NSInteger nextTag = textField.tag+1;
        UIView*nextTextField = [self viewWithTag:nextTag];
        [nextTextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSLog(@"down");
    
    [self searchWithWords:textField.text];
}



- (void)searchWithWords:(NSString*)words {
    
    if(words.length <= 0){
        
        return;
    }
    
    [_textField resignFirstResponder];
    
    if ([words hasPrefix:@"http"]) {
        
    } else {
        
        words = [NSString stringWithFormat:@"https://wap.baidu.com/from=1009547a/s?word=%@",words];
        //        NSString *transString = [NSString stringWithString:[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        words = [words stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    
    if(_tapURLBlock != nil){
        _tapURLBlock(words);
    }
    
}





@end
