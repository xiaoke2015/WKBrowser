//
//  RegTipViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RegTipViewController.h"

@interface RegTipViewController ()

@property (nonatomic ,strong)UITextView * textView ;


@end

@implementation RegTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"注册协议"];
    
    [self initTextView];
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



- (void)initTextView {
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 15, SCREEM_WIDTH , SCREEM_HEIGHT - 64 - 30)];
    _textView.font = FONT14;
    _textView.layer.masksToBounds = YES;
//    _textView.layer.cornerRadius = 4;
    _textView.editable = NO;
    
    
    [self.view addSubview:_textView];
    
    [self setText];
}



- (void)setText {
    
    
    //    NSString * textStr = @"宝宝树知道 是一款为新手妈妈提供孕期专业资讯的互动平台。产品服务于备孕、孕期及宝宝0-6岁的辣妈，陪你一同度过惊喜而又幸福的时光。数千万妈妈的选择，一定不会错！";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RegTip" ofType:@"txt"];
    
    NSString *textStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    
    paragraphStyle.firstLineHeadIndent = 20;
        paragraphStyle.headIndent = 15;//整体缩进(首行除外)
        paragraphStyle.tailIndent = SCREEM_WIDTH - 30;//
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:RGB(50, 50, 50),NSFontAttributeName:FONT14 ,NSParagraphStyleAttributeName:paragraphStyle};
    
    
    [attributedString setAttributes:attributes range:NSMakeRange(0, textStr.length)];
    
    
    _textView.attributedText = attributedString;
    
}



@end
