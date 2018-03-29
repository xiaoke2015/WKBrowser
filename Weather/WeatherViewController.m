//
//  WeatherViewController.m
//  DGWebBrowser
//
//  Created by 李加建 on 2017/11/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherViewController.h"

#import "WeatherView.h"

#import "TBActivityView.h"

@interface WeatherViewController ()

@property (nonatomic ,strong)WeatherView *weatherView;

@property (nonatomic)  TBActivityView *indicatorView;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self creatView];
    
    [self loadData2];
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
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
}



- (void)creatView {
    
    
    _weatherView = [[WeatherView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:_weatherView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    
    [btn setImage:[UIImage imageNamed:@"btn_back_w"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self creatBtn];
}


- (void)btnAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)creatBtn {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 50, 20, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    
//    self.btn2 = btn;
}


- (void)btn2Action {
    
    [self loadData2];
}





- (void)loadData2 {
    
    
    [self showWaitIndicator];
    
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
            
            _weatherView.model = model;
            
        }
        
        [self removeWaitIndicator];
        
    }];
    
    
}



- (TBActivityView *)indicatorView {
    if (!_indicatorView) {
        
        _indicatorView = [[TBActivityView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH - 70, 30)];
        [self.indicatorView setCenter:CGPointMake(SCREEM_WIDTH / 2.0, SCREEM_HEIGHT - 60)];
        [self.view addSubview:self.indicatorView];
    }
    return _indicatorView;
}

- (void)showWaitIndicator {
    [self.indicatorView startAnimate];
}

- (void)removeWaitIndicator {
    [self.indicatorView stopAnimate];
}




@end
