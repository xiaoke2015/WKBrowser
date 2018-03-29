//
//  CardsViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CardsViewController.h"

#import "DWebCardView.h"

@interface CardsViewController () < DWCardSwitchDelegate>

@property (nonatomic ,strong)UICollectionView *collectionView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)DWebCardView *cardSwitch;

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBA(25, 25, 25, 0.9);
    
    [self creatView];
    
    [self creatFootBarView];
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


- (void)creatView {
    
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    
    self.dataSource = searchBarView.pageArray;
    
    
    NSInteger selectedIndex = [self.dataSource indexOfObject:searchBarView.currentWebViewVC];
    

    _cardSwitch = [[DWebCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, (SCREEM_HEIGHT))];
    _cardSwitch.items = self.dataSource;
    _cardSwitch.delegate = self;
    //分页切换
    //    _cardSwitch.pagingEnabled = YES;
    //设置初始位置，默认为0
    _cardSwitch.selectedIndex = selectedIndex;
    [self.view addSubview:_cardSwitch];
}


- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    
    WKBrowserViewController *nextVC = searchBarView.pageArray[index];
    
    searchBarView.currentWebViewVC = nextVC ;
    searchBarView.currentWebView = nextVC.webView;
    
//    [self selectView];
    

    [self dismissViewControllerAnimated:NO completion:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selpageactopn" object:nil];
    }];
}


- (void)creatFootBarView {
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 44, SCREEM_WIDTH, 44)];
    
    footView.backgroundColor = RGBA(10, 10, 10, 0.5);
    [self.view addSubview:footView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 30, 0, 60, 44)];
    //    btn.backgroundColor = [UIColor redColor];
    [btn setImage:[UIImage imageNamed:@"root_add"] forState:UIControlStateNormal];
    [footView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 60, 0, 60, 44)];
    //    btn1.backgroundColor = [UIColor redColor];
    [btn1 setImage:[UIImage imageNamed:@"root_back"] forState:UIControlStateNormal];
    [footView addSubview:btn1];
    
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
}



- (void)btnAction {
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    [searchBarView addPage];
    
    self.dataSource = searchBarView.pageArray;
    
    [_cardSwitch reloadView];
    
    
    _cardSwitch.selectedIndex = self.dataSource.count - 1;
    
}


- (void)btn1Action {
    
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selpageactopn" object:nil];
    }];
    
}


- (void)reloadData {
    
    
    WKSearchBarView * searchBarView = [WKSearchBarView shareInstance];
    
    self.dataSource = searchBarView.pageArray;
    
    [self.collectionView reloadData];
}



@end
