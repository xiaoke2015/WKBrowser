//
//  SettingsViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsViewController.h"

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
    
    [self.dataSource addObject:@"清理缓存"];
    [self.dataSource addObject:@"无痕模式"];
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
    
    NSLog(@"%@",@(switchBtn.isOn));
    
     WKSearchBarView *searchBar = [WKSearchBarView shareInstance];
    
    if(switchBtn.isOn == YES){
        searchBar.titleBtn.backgroundColor = RGB(200, 200, 200);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wuheng"];
    }
    else {
        searchBar.titleBtn.backgroundColor = RGBA(255, 255, 255 , 0.7);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wuheng"];
    }
}




- (void)initTableView  {
    
    CGFloat y = 0;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y -64)];
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
    
    
    //    [self creatFootView];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        cell.textLabel.font = FONT14;
        cell.selectionStyle = NO;
    }
    
    
    if(_dataSource.count <= 0){
        
        return cell;
    }
    
 
    cell.textLabel.text = _dataSource[indexPath.row];
    
    if(indexPath.row == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = nil;
    }
    else if (indexPath.row == 1){
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = _switchBtn;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 0){
        
        [NetWorkManager clearCache];
    }
}


@end
