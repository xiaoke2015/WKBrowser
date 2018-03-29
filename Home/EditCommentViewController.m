//
//  EditCommentViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "EditCommentViewController.h"

#import "MSCommentModel.h"

#import "MLTextView.h"

@interface EditCommentViewController ()

@property (nonatomic ,strong)MLTextView *textView;

@end

@implementation EditCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"写评论"];
    
    [self initRightItem];
    
    [self creatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    [self setRightBarWithCustomView:btn];
    
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)rightItemAction {
    
    
    if(_textView.textView.text.length <=0){
        [HUDManager alertText:@"请输入内容"];
        return;
    }
    
    _model.content = _textView.textView.text;
    
    [MSCommentModel addCollectWithModel:_model block:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded == YES){
            
            [HUDManager alertText:@"评论成功"];
            if(_success != nil){
                _success();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            
            [HUDManager alertText:error.localizedDescription];
        }
        
    }];
    
}



- (void)creatView {
    
    _textView = [[MLTextView alloc]initWithFrame:CGRectMake(15, 20, SCREEM_WIDTH - 30, 120)];
    
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = RGB(200, 200, 200).CGColor;
    _textView.placeholder.text = @"写评论...";
    
    [self.view addSubview:_textView];
}


@end
