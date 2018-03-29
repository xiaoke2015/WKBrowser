//
//  LogViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "LogViewController.h"

#import "LogTextView.h"

#import "RegViewController.h"
#import "PwdViewController.h"



@interface LogViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;

@property (nonatomic ,strong)LogTextView * phone;
@property (nonatomic ,strong)LogTextView * password;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"登录"];
    
    [self initLeftItem];
    
    [self initHeadView];
    
    [self initTableView];
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



- (void)initLeftItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftBarWithCustomView:btn];

}

- (void)leftBtnAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (void)initHeadView {
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
    
    
    CGRect phonef = CGRectMake(30, 30, SCREEM_WIDTH - 60, 44);
    _phone = [[LogTextView alloc]initWithFrame:phonef placeholder:@"请输入用户名"];
    [_headView addSubview:_phone];

    _phone.textField.keyboardType = UIKeyboardTypeNamePhonePad;
    
    
    
    CGRect passwordf = CGRectMake(30, _phone.bottom + 20, SCREEM_WIDTH - 60, 44);
    _password = [[LogTextView alloc]initWithFrame:passwordf placeholder:@"请输入密码"];
    [_headView addSubview:_password];
    _password.textField.secureTextEntry = YES;


    
    
    CGRect loginf = CGRectMake(30, _password.bottom + 50, SCREEM_WIDTH - 60, 44);
    LogTextView *login = [[LogTextView alloc]initWithFrame:loginf ];
    login.backgroundColor = MAINCOLOR;
    [login setTitle:@"提交" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font = FONT15;
    [_headView addSubview:login];
    
    [login addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *reg = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 130, login.bottom+10, 100, 30)];
    [reg setTitle:@"注册账号" forState:UIControlStateNormal];
    [reg setTitleColor:GRAY100 forState:UIControlStateNormal];
    reg.titleLabel.font = FONT(13);
    [_headView addSubview:reg];
    reg.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [reg addTarget:self action:@selector(regAction) forControlEvents:UIControlEventTouchUpInside];
    

    
}



- (void)logAction {
    
    [self loadData];
}

- (void)regAction {
    
    RegViewController *nextVC = [[RegViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)pwdAction {
    
    PwdViewController *nextVC = [[PwdViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 64)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];;
    
    
    _tableView.tableHeaderView = _headView;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}



- (void)loadData {
    
    
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = _phone.textField.text;// 设置用户名
    user.password = @"123456";//_password.textField.text;// 设置密码
    user.email = @"tom@leancloud.cn";// 设置邮箱
    NSString *password2 = _password.textField.text;
 
    
    [AVUser logInWithUsernameInBackground:user.username password:user.password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        
        if (error == nil) {
            // 注册成功
            
            NSString * pwd2 = [user objectForKey:@"password2"];
            
            if([pwd2 isEqualToString:password2]){
                
                [HUDManager alertText:@"登录成功"];
                
                NSString *token = user.objectId;
                
                [UserManager loginWithToken:token];
                
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
