//
//  KKViewController.m
//  KKWeb
//
//  Created by 李加建 on 2017/11/21.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKViewController.h"

#import "KKCollectionViewCell.h"

#import "KKWebViewController.h"

#import "KKHeadBarView.h"

@interface KKViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic ,strong)UICollectionView *collectionView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)KKHeadBarView *headView;

@end

@implementation KKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgImg.image = [UIImage imageNamed:@"bgimgView"];
    bgImg.clipsToBounds = YES;
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgImg];
    
    self.dataSource = [NSMutableArray array];

    [self initHeadView];
    
    [self creatView];
    
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
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self checkStatus];
}



- (void)initHeadView {
    
    _headView = [[KKHeadBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 64)];
    
    [self.view addSubview:_headView];
    
    
    __weak typeof(self) weak = self;
    
    _headView.tapURLBlock = ^(NSString *url) {
        
        ItemModel *model = [ItemModel new];
        model.url = url;
        KKWebViewController *nextVC = [[KKWebViewController alloc]init];
        nextVC.model = model;
        [weak.navigationController pushViewController:nextVC animated:NO];
    };
    
    
    
    _headView.qrCodeBlock = ^{
        
    };
    
}



- (void)creatView {
    
    //确定是水平滚动，还是垂直滚动
    KKFlowLayout * flowLayout = [[KKFlowLayout alloc]init];
    //    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEM_WIDTH,SCREEM_HEIGHT - 44 - 64 ) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[KKCollectionViewCell class] forCellWithReuseIdentifier:@"KKCollectionViewCell"];
    
    
    [self.view addSubview:self.collectionView];
    
    //    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
}







#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataSource.count;
    
}



//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"KKCollectionViewCell";
    KKCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    ItemModel *model = self.dataSource[indexPath.row];
    
    cell.model = model;
    
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemModel *model = self.dataSource[indexPath.row];
    NSLog(@"%@",model);
    
    KKWebViewController *nextVC = [[KKWebViewController alloc]init];
    nextVC.model = model;
    [self.navigationController pushViewController:nextVC animated:NO];
    
}



- (void)loadData {
    
    [ItemModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:objects];
        
        [self.collectionView reloadData];
    }];
}



- (void)checkStatus {
    
    
    KKBootBarView *barView = [KKBootBarView shareInstance];
    
    barView.webView = nil;
    
    barView.goBackBtn.selected = NO;
    barView.goForwardBtn.selected = NO;
    
    barView.goHomeBtn.selected = NO;
}






@end
