//
//  PwdViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "PwdViewController.h"

#import "LogTextView.h"

@interface PwdViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;

@property (nonatomic ,strong)LogTextView * phone;
@property (nonatomic ,strong)LogTextView * password;
@property (nonatomic ,strong)LogTextView * passwordA;

@end

@implementation PwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"密码找回"];
    
    
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



- (void)initHeadView {
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
    
    
    CGRect phonef = CGRectMake(30, 30, SCREEM_WIDTH - 60, 44);
    _phone = [[LogTextView alloc]initWithFrame:phonef placeholder:@"请输入手机号码"];
    [_headView addSubview:_phone];
 
    _phone.textField.keyboardType = UIKeyboardTypeNamePhonePad;
    
    
    
    CGRect passwordaf = CGRectMake(30, _phone.bottom +20, SCREEM_WIDTH - 60, 44);
    _passwordA = [[LogTextView alloc]initWithFrame:passwordaf placeholder:@"输入新密码"];
    [_headView addSubview:_passwordA];
    _passwordA.textField.secureTextEntry = YES;

    
    CGRect passwordf = CGRectMake(30, _passwordA.bottom +20, SCREEM_WIDTH - 60, 44);
    _password = [[LogTextView alloc]initWithFrame:passwordf placeholder:@"再次输入新密码"];
    [_headView addSubview:_password];
    _password.textField.secureTextEntry = YES;

    
    
    
    CGRect loginf = CGRectMake(30, _password.bottom +50, SCREEM_WIDTH - 60, 44);
    LogTextView *login = [[LogTextView alloc]initWithFrame:loginf ];
    login.backgroundColor = MAINCOLOR;
    [login setTitle:@"提交" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font = FONT15;
    [_headView addSubview:login];
    
    [login addTarget:self action:@selector(logAction) forControlEvents:UIControlEventTouchUpInside];
    
 
    
    
}



- (void)logAction {
    
    [self loadData];
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
    _tableView.backgroundColor = [UIColor whiteColor];
    
    
    
    
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
    
    
    if([_passwordA.textField.text isEqualToString:_password.textField.text] == NO){
        [HUDManager alertText:@"两次输入密码不一致"];
        return;
    }
    
    
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = _phone.textField.text;// 设置用户名
    user.password =  @"123456";// 设置密码
    user.email = @"tom@leancloud.cn";// 设置邮箱
    
    NSString *password2 = _password.textField.text;
    
    [AVUser logInWithUsernameInBackground:user.username password:user.password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
       
        [user setObject:password2 forKey:@"password2"];
        
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
           
            if(succeeded == YES){
                
                [HUDManager alertText:@"修改成功"];
            }
            
        }];
    }];
}



@end
