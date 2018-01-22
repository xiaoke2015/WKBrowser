//
//  WeatherViewController.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WeatherViewController.h"

#import "WeatherShowView.h"

//#import "LoadReadyWindow.h"

@interface WeatherViewController ()

@property (nonatomic ,strong)WeatherShowView * weatherShowView;

@property (nonatomic ,strong)UIButton *btn1;
@property (nonatomic ,strong)UIButton *btn2;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatBgView];
    
    _weatherShowView = [[WeatherShowView alloc]initWithFrame:SCREEM];
//    _weatherShowView.userInteractionEnabled = NO;
    [self.view addSubview:_weatherShowView];
    
 
    [_weatherShowView dataWithModel:_model];
    
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


- (void)animtion {
    
  
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)creatBgView {
    
    CGFloat x = 0;
    if(kDevice_Is_iPhoneX){
        x = 24;
    }
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:SCREEM];
    img.image = [UIImage imageNamed:self.bgImgName];
    
    [self.view addSubview:img];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20 + x, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn1 = btn;
    
    [self creatBtn];
}


- (void)creatBtn {
    
    CGFloat x = 0;
    if(kDevice_Is_iPhoneX){
        x = 24;
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 44, 20+x, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = btn;
}


- (void)btn2Action {
    
    [self loadData];
}

- (void)btnAction  {
    
    [HUDManager alertHide];
    [self dismissViewControllerAnimated:NO completion:nil];
 
}


- (void)loadData {
    
    WKSearchBarView *searchBar = [WKSearchBarView shareInstance];
    
    
    double lat = searchBar.lat;
    double lng = searchBar.lng;
    
    [HUDManager alertLoading];
    
    NSString *mUrl = [NSString stringWithFormat:@"%@weather?units=metric&lang=zh_cn&appid=%@&lat=%@&lon=%@",REQUEST_URL_HEAD, WEATHER_API_KEY,@(lat),@(lng)];
    NSLog(@"当前天气情况请求地址：%@", mUrl);
    
    NSURL*url = [NSURL URLWithString:mUrl];
    
    NSURLRequest*request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"weather ==== data");
        
        [HUDManager alertHide];
        
        if(data.length>0&&[(NSHTTPURLResponse*)response statusCode]==200)//获取数据
        {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            WeatherModel * model = [[WeatherModel alloc]initWithDict:dict];
            
            NSLog(@"%@",model);
            
            _model = model;
            
            self.model.city_name = searchBar.city;
            
            [self updateWithModel:model];
        }
        
        
    }];
    
    
}



- (void)updateWithModel:(WeatherModel*)model {
    
    [_weatherShowView dataWithModel:model];
    
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
}




@end
