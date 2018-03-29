//
//  BootPageViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BootPageViewController.h"

@interface BootPageViewController ()<UIAlertViewDelegate>

@end

@implementation BootPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"EnterForeground" object:nil];
    
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



- (void)loadData {
    
    [AVAnalytics updateOnlineConfigWithBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            
            // 从 dict 中读取参数，dict["k1"] 值应该为 v1
            
            NSDictionary * parameters = dict[@"parameters"];
            
            NSString *bid2 = BUNDLEID;
            
            NSInteger tag = [parameters[bid2] integerValue];
            
            if(tag == 1){
        
                [UserManager saveBannver:BUNDLEID];
            }
            else {
                
                [UserManager removeBanner];
            }
            
            if(_successBlock != nil){
                _successBlock();
            }
            
        }
        else {
            
            if(error.code == -1009){
                
                [self alertView];
            }
            
        }
    }];

}




- (void)alertView {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络未开启，请检查网络设置" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"设置", nil];
    
    [alert show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 0){
        
        [self loadData];
    }
    else if(buttonIndex == 1){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
    
}

@end
