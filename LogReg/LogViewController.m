//
//  LogViewController.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "LogViewController.h"

#import "RegViewController.h"

@interface LogViewController ()

@property (nonatomic ,strong)UITextField *phone;
@property (nonatomic ,strong)UITextField *password;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGB(79, 144, 244).CGColor,
                       (id)RGB(83, 187, 245).CGColor,
                       (id)RGB(150, 241, 252).CGColor, nil];
    //    gradient.startPoint = CGPointMake(0, 0);
    //    gradient.endPoint = CGPointMake(1, 1);
    //    gradient.locations = @[@0.0, @0.2, @0.5];
    [self.view.layer addSublayer:gradient];
    
    [self creatView];
    
    [self initBackBtn];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 80, 27, 160, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    
    [self.view addSubview:label];
    
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


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
}



- (void)initBackBtn {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"btn_back_w"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)creatView {
    
    
    _phone = [[UITextField alloc]initWithFrame:CGRectMake(20, 120, SCREEM_WIDTH - 40, 44)];
    
    
    _phone.font = FONT(15);
    _phone.placeholder = @"请输入账号";
    [self.view addSubview:_phone];
    _phone.backgroundColor = [UIColor whiteColor];
    
    _phone.leftViewMode = UITextFieldViewModeAlways;
    _phone.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    _password = [[UITextField alloc]initWithFrame:CGRectMake(20, _phone.bottom +20, SCREEM_WIDTH - 40, 44)];
    
    
    _password.font = FONT(15);
    _password.placeholder = @"请输入密码";
    [self.view addSubview:_password];
    _password.backgroundColor = [UIColor whiteColor];
    
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, _password.bottom + 50, SCREEM_WIDTH - 40, 44)];
    
    btn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 50, 20, 50, 44)];
    
//    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"注册" forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT(14);
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(regVCAction) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)regVCAction {
    
    RegViewController *nextVC = [[RegViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}



- (void)logAction {
    
    if(_phone.text.length >0 && _password.text.length > 0){
        
        [self loadData];
    }
    else {
        
        [HUDManager alertText:@"请输入账号和密码"];
    }
    
    
}


- (void)loadData {
    
    
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = _phone.text;// 设置用户名
    user.password = @"123456";//_password.textField.text;// 设置密码
    user.email = @"tom@leancloud.cn";// 设置邮箱
    NSString *password2 = _password.text;
    
    
    [AVUser logInWithUsernameInBackground:user.username password:user.password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        
        if (error == nil) {
            // 注册成功
            
            NSString * pwd2 = [user objectForKey:@"password2"];
            
            if([pwd2 isEqualToString:password2]){
                
                [HUDManager alertText:@"登录成功"];
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                
                [HUDManager alertText:@"密码不正确"];
            }
            
            
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            
            [HUDManager alertText:@"登录失败"];
        }
    }];
    
    
    
}




@end
