//
//  InfoViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoViewController.h"

#import "InfoTableViewCell.h"

#import "InfoHeadView.h"

#import "InfoListViewController.h"

#import "CollectViewController.h"
#import "RecordViewController.h"

#import "MYCommentViewController.h"

#import "MYCollectViewController.h"

@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)InfoHeadView *headView;
@property (nonatomic ,strong)AlphaView *headBarView;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@""];
    
    
    _dataSource = [NSMutableArray arrayWithArray:@[@"个人信息",@"我的收藏",@"我的评论",@"历史记录",@"文章收藏",@"退出登录"]];
    _tableArr = @[@"info_001",@"info_002",@"info_004",@"info_003",@"info_005",@""];
    
    [self initHeadView];
    
    [self initTableView];
    
    [self.view addSubview:self.headBarView];
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


- (AlphaView*)headBarView {
    
    if(_headBarView == nil){
        
        _headBarView = [[AlphaView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 64)];
        //        _headBarView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_headBarView];
        
        [self creatHeadBar];
    }
    
    return _headBarView;
}

- (void)creatHeadBar {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 80, 27, 160, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我的";
    label.textColor = RGB(255, 255, 255);
    
    [_headBarView addSubview:label];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];

    [_headBarView addSubview:btn];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self update];
}



- (void)update {
    
    AVUser *user = [AVUser currentUser];
    
    if(user != nil){
        
        AVFile *file = [user objectForKey:@"avatar"];
        
        NSString * name = [user objectForKey:@"name"];
        
        _headView.name.text = name;
        
        [_headView.imgView sd_setImageWithURL:[NSURL URLWithString:file.url] placeholderImage:[UIImage imageNamed:@"avatar"]];
    }
    else {
        
        _headView.name.text = @"未登录";
        _headView.imgView.image = [UIImage imageNamed:@"avatar"];
    }
    
}


- (void)initLeftItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
    
}

- (void)leftBtnAction {
    
    //    MsgViewController *nextVC = [[MsgViewController alloc]init];
    //    nextVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:nextVC animated:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (void)initHeadView {
    
    InfoHeadView *headView = [[InfoHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 190)];
    headView.backgroundColor = [UIColor whiteColor];
    //    [_headView dataWithModel:_model];
    
    [headView setGoBlock:^(NSInteger tag){
        
        [self headActionWithTag:tag];
    }];
    
    [headView setGoBlock1:^{
        
        InfoListViewController *nextVC = [[InfoListViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    
    _headView = headView;
    
}


- (void)headActionWithTag:(NSInteger)tag {
    
    
    
    
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 0) style:UITableViewStyleGrouped];
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
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
    _tableView.tableHeaderView = _headView;
    
    _tableView.tableFooterView = [[UIView alloc]init];
    
//        [self creatFootView];
    
   
}


- (void)headRefreshing {
    
    //    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
    [self loadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0){
        
        return 5;
    }
    else if (section == 1){
        
        return 1;
    }
    
    return _dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[InfoTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    if(indexPath.section == 0){
        
        cell.textLabel.font = FONT15;
        cell.textLabel.text = _dataSource[indexPath.row];
        
        NSString *imgName = _tableArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imgName];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 1){
        cell.textLabel.font = FONT15;
        cell.textLabel.text = _dataSource[indexPath.row + 5];
        
        NSString *imgName = _tableArr[indexPath.row + 5];
        cell.imageView.image = [UIImage imageNamed:imgName];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger tag = indexPath.row + indexPath.section*10;
    
    [self didSelectWithTag:tag];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView  {
    
    [self.headBarView scrollWithY:scrollView.contentOffset.y];
}


- (void)didSelectWithTag:(NSInteger)tag {
    
    if(tag == 0){
        
        
        InfoListViewController *nextVC = [[InfoListViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 1){
     
        
        CollectViewController *nextVC = [[CollectViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [nextVC setInfo:@"1"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 2){
        
        
        MYCommentViewController *nextVC = [[MYCommentViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
//        [nextVC setInfo:@"1"];
        [self.navigationController pushViewController:nextVC animated:YES];
        
    }
    else if (tag == 3){
        

        RecordViewController *nextVC = [[RecordViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [nextVC setInfo:@"1"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 4){
        
        
        MYCollectViewController *nextVC = [[MYCollectViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 10){
        
        [AVUser logOut];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}



- (void)loadData {
    
    
}




@end
