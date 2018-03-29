//
//  KKRootViewController.m
//  KKWeb
//
//  Created by 李加建 on 2017/11/22.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KKRootViewController.h"

#import "KKViewController.h"

#define SG_EXPOSED_TRANSFORM (CGAffineTransformMakeScale(0.75, 0.75))

#import "KKBootBarView.h"

#import "KKHeadBarView.h"

#import "DHeadView.h"

#import "LogViewController.h"

#import "WKPopView.h"

#import "SettingsViewController.h"
#import "CollectViewController.h"
#import "RecordViewController.h"

#import "LocationManager.h"

#import "WeatherModel.h"

#import "WeatherViewController.h"

#import "KKWebViewController.h"

@interface KKRootViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView *scrollView;

@property (nonatomic ,strong)NSMutableArray *viewControllers;

@property (nonatomic ,strong)UIPageControl *pageControl;

@property (assign, nonatomic) BOOL exposeMode;

@property (nonatomic,strong)LocationManager *manager;

@end

@implementation KKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma detail 设置偏移量
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

    self.viewControllers = [NSMutableArray array];
    
    JKBaseNavigationController *navi = [[JKBaseNavigationController alloc]initWithRootViewController:[[KKViewController alloc] init]];
    
    [self.viewControllers addObject:navi];
    
    [self initScrollView];
    
    DHeadView *headView = [[DHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    [self.view addSubview:headView];
    
    [headView.addBtn addTarget:self action:@selector(addPageAction) forControlEvents:UIControlEventTouchUpInside];
    [headView.backBtn addTarget:self action:@selector(backPageAction) forControlEvents:UIControlEventTouchUpInside];
    [headView.delBtn addTarget:self action:@selector(delBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    KKBootBarView *barView = [KKBootBarView shareInstance];
    
    [self.view addSubview:barView];

    
    [self layoutPages];
    [self setCurrentPage];
    
    [self registerNotification];
    
    [self getLocation];
    
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
}



- (void)getLocation {
    
    _manager = [[LocationManager alloc]init];
    
    [_manager findMe];

    __weak typeof(self) weakSelf = self;
    
    _manager.getAddress = ^(NSString *city ,double lng , double lat){
        
        NSLog(@"city = %@",city);
        
        if(city.length > 0){
            
            WeatherModel * model = [WeatherModel currentWeather];
            model.city_name = city;
            model.coord = CLLocationCoordinate2DMake(lat, lng);
        }
    
        
        [weakSelf loadData2];
        
    };
    
}


- (void)loadData2 {
    
    WeatherModel * model = [WeatherModel currentWeather];

    double lat = model.coord.latitude;
    double lng = model.coord.longitude;
    
    NSString *mUrl = [NSString stringWithFormat:@"%@weather?units=metric&lang=zh_cn&appid=%@&lat=%@&lon=%@",REQUEST_URL_HEAD, WEATHER_API_KEY,@(lat),@(lng)];
    
    NSLog(@"当前天气情况请求地址：%@", mUrl);
    
    NSURL*url = [NSURL URLWithString:mUrl];
    
    NSURLRequest*request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"weather ==2== data");
        
        if(data.length>0&&[(NSHTTPURLResponse*)response statusCode]==200)//获取数据
        {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            [model modelWithDict:dict];
          
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherupdate" object:nil];
            
            NSLog(@"weatherupdate");
        }
        
    }];
    
}



- (void)registerNotification {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWebPage) name:@"addwebpage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHomeAction) name:@"gohomeaction" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreBtnAction) name:@"moreaction" object:nil];
}





- (void)moreBtnAction {
    
    
    JKBaseNavigationController * vc = [self currentNavi];
    
    // 判断当前页是否是 网页控制器
    
    BOOL isWeb = NO;
    
    if([vc.topViewController class] == [KKWebViewController class]){
        
        isWeb = YES;
    }

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [WKPopView showInView:window isWeb:isWeb success:^(NSInteger tag) {
        
        if(tag == 11){
         
            [self getLocation];
        }
        else {
            
            [self popActionWithTag:tag];
        }
    }];
    
}


- (void)pushNextWebWithModel:(RecordModel*)record {
    
    
    JKBaseNavigationController * vc = [self currentNavi];
    
    
    ItemModel *model = [ItemModel new];
    
    NSLog(@"%@",model);
    model.url = record.url;
    model.title = record.title;
    
    KKWebViewController *nextVC = [[KKWebViewController alloc]init];
    nextVC.model = model;
    [vc pushViewController:nextVC animated:NO];
}



- (void)popActionWithTag:(NSInteger)tag {
    
    if(tag == 0){
        
        RecordViewController *nextVC = [[RecordViewController alloc]init];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        [self presentViewController:navi animated:YES completion:nil];
        
        nextVC.didSelModel = ^(RecordModel *model) {
            
            [self pushNextWebWithModel:model];
        };
        
    }
    else if (tag == 1){
        
        CollectViewController *nextVC = [[CollectViewController alloc]init];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        [self presentViewController:navi animated:YES completion:nil];
        
        nextVC.didSelModel = ^(RecordModel *model) {
            
            [self pushNextWebWithModel:model];
        };
    }
    else if (tag == 2){
        
        JKBaseNavigationController * vc = [self currentNavi];
        
        // 判断当前页是否是 网页控制器
        
        if([vc.topViewController class] == [KKWebViewController class]){
            
            KKWebViewController * nextVC = (KKWebViewController*)vc.topViewController;
            
            NSString *title = nextVC.model.changeTitle;
            NSString *url = nextVC.model.changeUrl;
            
            if(title.length >0 && url.length >0){
                
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = url;
                
                [HUDManager alertText:@"复制成功"];
            }
        }
    }
    else if (tag == 3){
        
        [self shareAction];
    }
    else if (tag == 7){
        
        SettingsViewController *nextVC = [[SettingsViewController alloc]init];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:nextVC];
        
        [self presentViewController:navi animated:YES completion:nil];
        
    }
    else if (tag == 4){
        
        
        JKBaseNavigationController * vc = [self currentNavi];
        
        // 判断当前页是否是 网页控制器
        
        if([vc.topViewController class] == [KKWebViewController class]){
            
            KKWebViewController * nextVC = (KKWebViewController*)vc.topViewController;
            
            NSString *title = nextVC.model.changeTitle;
            NSString *url = nextVC.model.changeUrl;
    
            if(title.length >0 && url.length >0){
    
                [[RecordDataBase alloc] insertCollWithTitle:title url:url ];
    
                [HUDManager alertText:@"收藏成功"];
            }
        }
        
    }
    else if (tag == 10){
    
        WeatherViewController * nextVC = [[WeatherViewController alloc]init];
        
        [self presentViewController:nextVC animated:YES completion:nil];
        
    }
}


- (void)shareAction {
    
    
    
    JKBaseNavigationController * vc = [self currentNavi];
    
    // 判断当前页是否是 网页控制器
    
    if([vc.topViewController class] == [KKWebViewController class]){
        
        KKWebViewController * nextVC = (KKWebViewController*)vc.topViewController;
        
        NSString *title = nextVC.model.changeTitle;
        NSString *url = nextVC.model.changeUrl;
        
        NSString * string = url;
        
        NSString *share_title = title;
        NSString *share_url = string;
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[share_title,[NSURL URLWithString:share_url]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];
    }
    
}



#pragma mark 页面打开
- (void)addWebPage {
    
    self.exposeMode = YES;
    
    NSLog(@"exposeMode = %@",@(_exposeMode));
    
}


- (void)goHomeAction {
    
    NSLog(@"gohome");
    
    int page = floor(_scrollView.contentOffset.x/self.view.frame.size.width+0.5);
    
    JKBaseNavigationController *vc = self.viewControllers[page];
    
    NSLog(@"%@ , %@",vc.viewControllers ,vc.topViewController);
    
//    [vc popViewControllerAnimated:NO];
    
    [vc popToRootViewControllerAnimated:NO];
    
    
}


#pragma 增加页面
- (void)addPageAction {
    
    NSLog(@"addPageAction");
    
    JKBaseNavigationController *navi = [[JKBaseNavigationController alloc]initWithRootViewController:[[KKViewController alloc] init]];
    
    [self.viewControllers addObject:navi];
    
    [self layoutPages];
    
    NSInteger index = self.viewControllers.count - 1;
    
    CGPoint off = CGPointMake(_scrollView.frame.size.width * index, 0);

    [UIView animateWithDuration:0.2 animations:^{
        
        [self layoutPages];
        [self layoutBoot];
        
    } completion:^(BOOL finished) {
        
        [_scrollView setContentOffset:off animated:YES];
        
        [self checkPage];
    }];
    
    
}

#pragma mark 返回
- (void)backPageAction {
    
    self.exposeMode = NO;
}

#pragma mark 删除页面事件
- (void)delBtnAction {
    
    int page = floor(_scrollView.contentOffset.x/self.view.frame.size.width+0.5);
    
    JKBaseNavigationController *vc = self.viewControllers[page];
    
    [self.viewControllers removeObject:vc];
    
    [vc.view removeFromSuperview];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self layoutPages];
        [self layoutBoot];
        
    } completion:^(BOOL finished) {
        
        if(self.viewControllers.count <=0){
            
            [self addPageAction];
        }
        
        [self checkPage];
    }];
}



#pragma mark 设置 页面打开还是显示
- (void)setExposeMode:(BOOL)exposeMode {
    
    _exposeMode = exposeMode;
    if (exposeMode) {
       
        UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tappedViewController:)];
        
        rec.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:rec];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
        [self setCurrentPage];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self layoutPages];
            [self layoutBoot];
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
      
        
        UITapGestureRecognizer *rec = [self.view.gestureRecognizers lastObject];
        if (rec != nil) {
            [self.view removeGestureRecognizer:rec];
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self layoutPages];
            [self layoutBoot];
            
        } completion:^(BOOL finished) {
            
            [self setCurrentPage];
        }];
    }

}

#pragma mark 点击隐藏

- (void)_tappedViewController:(UITapGestureRecognizer*)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        int page = floor(_scrollView.contentOffset.x/self.view.frame.size.width+0.5);
        
        JKBaseNavigationController *vc = self.viewControllers[page];
        
        UIView *view = vc.view;
        CGPoint pos = [recognizer locationInView:view];
        CGRect rect = CGRectInset(view.bounds, 20, 20);
        if (CGRectContainsPoint(rect, pos)) {
           
            self.exposeMode = NO;
            
        }
    }
}


#pragma mark scrollView 初始化

- (void)initScrollView {
    


    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    
    _scrollView.pagingEnabled = YES;
    
    [self layoutPages];
    
    [self loadpageControl];
}



-(void)loadpageControl {
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT*0.93, SCREEM_WIDTH, 20)];
    _pageControl.numberOfPages = self.viewControllers.count;
    _pageControl.currentPage = 0;
    //    UIImage * pre= [UIImage imageNamed:@"uikit_page_normal"];
    //    UIImage * pre1= [UIImage imageNamed:@"star"];
    _pageControl.pageIndicatorTintColor =  RGB(100, 100, 100);//[UIColor colorWithPatternImage:pre];
    _pageControl.currentPageIndicatorTintColor = RGB(255, 255, 255);//[UIColor colorWithPatternImage:pre1];
    [self.view addSubview:_pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = floor(_scrollView.contentOffset.x/SCREEM_WIDTH+0.5);
    
    _pageControl.currentPage = page;
}




#pragma mark layout 页面
- (void)layoutPages {
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*self.viewControllers.count, 0);
    
    for(int i=0;i<self.viewControllers.count;i++){
        
        JKBaseNavigationController *vc = self.viewControllers[i];
        
        vc.view.transform = CGAffineTransformIdentity;
        
        vc.view.frame = CGRectMake(SCREEM_WIDTH*i, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 0 - 44);
        
        [_scrollView addSubview:vc.view];
     
        if(_exposeMode) {
            
//            vc.view.transform = SG_EXPOSED_TRANSFORM;
            
            CGAffineTransform transform;
            
            transform = CGAffineTransformMakeTranslation(0, 44);
            transform = CGAffineTransformScale(transform, 0.75, 0.75);
            
            vc.view.transform = transform;
            
            vc.view.userInteractionEnabled = NO;
            
        }
        else {
            
            vc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
            vc.view.userInteractionEnabled = YES;
        }
    }
    
}

#pragma mark 设置当前页
- (void)setCurrentPage {
    
    if(_exposeMode == NO){
        
        int page = floor(_scrollView.contentOffset.x/self.view.frame.size.width+0.5);

        JKBaseNavigationController *vc = self.viewControllers[page];
        
        vc.view.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 0 - 44);
        
        [self.view addSubview:vc.view];
        
        // 判断当前页是否是 网页控制器
        
        if([vc.topViewController class] == [KKWebViewController class]){
            
            KKWebViewController * nextVC = (KKWebViewController*)vc.topViewController;
            
            [nextVC checkSearchStatus];
        }
        
    }
    else {
        
        int page = floor(_scrollView.contentOffset.x/self.view.frame.size.width+0.5);
        
        JKBaseNavigationController *vc = self.viewControllers[page];
        
        vc.view.frame = CGRectMake(SCREEM_WIDTH*page, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 0 - 44);
        
        [_scrollView addSubview:vc.view];
    }

}


#pragma mark 头部和底部动画变换
- (void)layoutBoot {
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    KKBootBarView *barView = [KKBootBarView shareInstance];
    
//    KKHeadBarView *headBar = [KKHeadBarView shareInstance];
    
    if(_exposeMode ){
        
        barView.frame = CGRectMake(0, h, w, barView.frame.size.height);
//        headBar.frame = CGRectMake(0, -64, w, 64);
    }
    else {
        
        barView.frame = CGRectMake(0, h - barView.frame.size.height , w, barView.frame.size.height);
//        headBar.frame = CGRectMake(0, 0, w, 64);
    }
    
}



#pragma mark 更新页面
- (void)checkPage {
    
    NSInteger pages = self.viewControllers.count;

    KKBootBarView *barView = [KKBootBarView shareInstance];
    
    barView.pageLabel.text = [NSString stringWithFormat:@"%@",@(pages)];
    
    _pageControl.numberOfPages = self.viewControllers.count;
    
    int page = floor(_scrollView.contentOffset.x/SCREEM_WIDTH+0.5);
    
    _pageControl.currentPage = page;
    
}



- (JKBaseNavigationController *)currentNavi {
    
    int page = floor(_scrollView.contentOffset.x/self.view.frame.size.width+0.5);
    
    JKBaseNavigationController *vc = self.viewControllers[page];
    
    return vc;
    
}







@end
