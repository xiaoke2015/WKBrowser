//
//  RegViewController.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RegViewController.h"

#import "RegTipViewController.h"

@interface RegViewController ()

@property (nonatomic ,strong)UITextField *phone;
@property (nonatomic ,strong)UITextField *password;
@property (nonatomic ,strong)UITextField *passwordA;

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initNaviBarBtn:@"注册"];
    
    ((UILabel*)self.customView).textColor = RGB(50, 50, 50);
    
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



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
}


- (void)creatView {
    
    
    _phone = [[UITextField alloc]initWithFrame:CGRectMake(20, 60, SCREEM_WIDTH - 40, 44)];
    
    
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
    
    _passwordA = [[UITextField alloc]initWithFrame:CGRectMake(20, _password.bottom +20, SCREEM_WIDTH - 40, 44)];
    
    
    _passwordA.font = FONT(15);
    _passwordA.placeholder = @"请再次输入密码";
    [self.view addSubview:_passwordA];
    _passwordA.backgroundColor = [UIColor whiteColor];
    
    _passwordA.leftViewMode = UITextFieldViewModeAlways;
    _passwordA.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, _passwordA.bottom +40, SCREEM_WIDTH - 40, 44)];
    
    btn.backgroundColor = RGB(52, 152, 219);
    [self.view addSubview:btn];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _phone.layer.borderWidth = 1;
    _phone.layer.borderColor = RGB(200, 200, 200).CGColor;
    
    _password.layer.borderWidth = 1;
    _password.layer.borderColor = RGB(200, 200, 200).CGColor;
    
    _passwordA.layer.borderWidth = 1;
    _passwordA.layer.borderColor = RGB(200, 200, 200).CGColor;
    
    [self initTipBtn];
    
}



- (void)initTipBtn {
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(30, _passwordA.bottom+10, SCREEM_WIDTH - 60, 30)];
    
    [btn setImage:[UIImage imageNamed:@"img_reg"] forState:UIControlStateNormal];
    
    [btn setAttributedTitle:[self setTip] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnTipAction) forControlEvents:UIControlEventTouchUpInside];
}

- (NSAttributedString *)setTip {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT(11),NSForegroundColorAttributeName:RGB(100, 100, 100)};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT(11),NSForegroundColorAttributeName:RGB(247, 124, 126)};
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:@"我已阅读同意" attributes:attributes1];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"《用户协议及隐私权声明》" attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr2];
    
    return attrStr;
}


- (void)btnTipAction {
    
    RegTipViewController *nextVC = [[RegTipViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (void)regVCAction {
    
    RegTipViewController *nextVC = [[RegTipViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}






- (void)logAction {
    
    
    [self loadData];
}



- (void)loadData {
    
    if([_passwordA.text isEqualToString:_password.text] == NO){
        [HUDManager alertText:@"两次输入密码不一致"];
        return;
    }
    
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = _phone.text;// 设置用户名
    user.password = @"123456";// 设置密码
    user.email = [NSString stringWithFormat:@"%@@leancloud.cn",user.username];// 设置邮箱
    
    NSString *password2 = _password.text;
    
    [user setObject:password2 forKey:@"password2"];
    [user setObject:@"我的简介" forKey:@"detail"];
    [user setObject:@"男" forKey:@"sex"];
    
    NSString *name = [NSString stringWithFormat:@"用户%@",@(arc4random() % 9999)];
    [user setObject:name forKey:@"name"];
    
    NSData*imageData  = UIImageJPEGRepresentation([UIImage imageNamed:@"avatar@2x.png"], 0.5);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@0%@.jpg", str,@(02)];
    
    AVFile *file = [AVFile fileWithName:fileName data:imageData];
    
    [user setObject:file forKey:@"avatar"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        
        if (succeeded) {
            // 注册成功
            
            [HUDManager alertText:@"注册成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            
            [HUDManager alertText:@"注册失败"];
        }
    }];
    
}




@end
