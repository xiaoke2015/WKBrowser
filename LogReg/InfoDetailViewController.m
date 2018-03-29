//
//  InfoDetailViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoDetailViewController.h"



@interface InfoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UITextView * textView ;

@property (nonatomic ,strong)UIView * bgView ;

@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"个人信息"];
    
    [self initLeftItem];
    
    [self initTextView];
    
    [self initTableView];
    
    [self loadData];
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
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)initTextView {
    
    
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
    
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 30, SCREEM_HEIGHT - 64 - 30)];
    _textView.font = FONT14;
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 4;
    
    
    [_bgView addSubview:_textView];
}



- (void)initLeftItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
//    [btn setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT15;
    
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
    
}

- (void)leftBtnAction {
    
    
    NSLog(@"save");
    
    AVUser *user = [AVUser currentUser];
    
    [user setObject:_textView.text forKey:@"detail"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        [HUDManager alertText:@"保存成功"];
    }];
    

}



- (void)loadData {
    
    AVUser *user = [AVUser currentUser];
    
    NSString *text = [user objectForKey:@"detail"];
    
    _textView.text = text;
    
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 50)];
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
    _tableView.backgroundColor = GRAYCOLOR;
    
 
    _tableView.tableHeaderView = _bgView;
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}




@end
