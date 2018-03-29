//
//  SettingsViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsViewController.h"

#import "SettingsTableViewCell.h"

#import <LeanCloudFeedback/LeanCloudFeedback.h>

#import "AboutViewController.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UISwitch *switchBtn;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPresentBarBtn:@"设置"];
    
    self.dataSource = [NSMutableArray array];
    
    [self.dataSource addObject:@"当前版本"];
    [self.dataSource addObject:@"UA标识"];
    [self.dataSource addObject:@"关于我们"];
    [self.dataSource addObject:@"意见反馈"];
    [self.dataSource addObject:@"清理缓存"];
    [self.dataSource addObject:@"恢复默认设置"];
//    [self.dataSource addObject:@""];
    
    [self initSwitch];
    
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

- (void)initSwitch {
    
    _switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 90, 0, 60, 40)];
    
    [_switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    BOOL hasPwd = [[NSUserDefaults standardUserDefaults] boolForKey:@"wuheng"];
    
    [_switchBtn setOn:hasPwd];
}

- (void)switchBtnAction:(UISwitch*)switchBtn {
    
   
}




- (void)initTableView  {
    
    CGFloat y = 0;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y -64) style:UITableViewStyleGrouped];
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
    _tableView.backgroundColor = RGB(240, 240, 240);
    
    //    [self creatFootView];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(section == 0){
        
        return _dataSource.count - 1;
    }
    else if (section == 1){
        
        return 1;
    }
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingsTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[SettingsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
        cell.textLabel.font = FONT(16);
        cell.selectionStyle = NO;
    }
    
    
    if(_dataSource.count <= 0){
        
        return cell;
    }
    
    
    
    if(indexPath.row == 0 && indexPath.section == 0){
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = _dataSource[0];
        
        cell.detailTextLabel.text = @"1.0";
        
    }
    else if (indexPath.row == 1 && indexPath.section == 0){
        
        cell.textLabel.text = _dataSource[1];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryNone ;
        
        
        cell.detailTextLabel.text = [UIDevice currentDevice].model;
    }
    else if (indexPath.row == 2 && indexPath.section == 0){
        
        cell.textLabel.text = _dataSource[2];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        
        cell.detailTextLabel.text = nil;
    }
    else if (indexPath.row == 3 && indexPath.section == 0){
     
        cell.textLabel.text = _dataSource[3];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        
        cell.detailTextLabel.text = nil;
    }
    else if (indexPath.row == 4 && indexPath.section == 0){
        
        cell.textLabel.text = _dataSource[4];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        
        cell.detailTextLabel.text = nil;
    }
    else if (indexPath.row == 0 && indexPath.section == 1){
        
        cell.textLabel.text = _dataSource[5];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone ;
        
        cell.detailTextLabel.text = nil;
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 2 && indexPath.section == 0){
        
        AboutViewController *nextVC = [[AboutViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (indexPath.row == 3 && indexPath.section == 0){
        
        LCUserFeedbackAgent *agent = [LCUserFeedbackAgent sharedInstance];
        /* title 传 nil 表示将第一条消息作为反馈的标题。 contact 也可以传入 nil，由用户来填写联系方式。*/
        [agent showConversations:self title:nil contact:nil];
    }
    else if (indexPath.row == 4 && indexPath.section == 0){
        
        [NetWorkManager clearCache];
    }
    else if (indexPath.row == 0 && indexPath.section == 1){
        
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"yejian"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wuheng"];
    }
}


@end
