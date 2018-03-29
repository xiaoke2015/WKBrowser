//
//  AboutViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic ,strong)UITextView * textView ;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"关于我们"];
    
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

    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 30, SCREEM_HEIGHT - 64 - 30)];
    _textView.font = FONT(14);
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 4;
    _textView.editable = NO;
    
    
    [self.view addSubview:_textView];
    
    [self setText];
}



- (void)setText {
    
    
    NSString * textStr = @"浏览器是专为你打造的浏览器，强大云加速、精选快捷网址、极简的设计风格，给你畅快的上网体验。我们致力于为用户提供简单、有趣的软件服务。";
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    
    paragraphStyle.firstLineHeadIndent = 20;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:RGB(50, 50, 50),NSFontAttributeName:FONT(14) ,NSParagraphStyleAttributeName:paragraphStyle};
 
    
    [attributedString setAttributes:attributes range:NSMakeRange(0, textStr.length)];
    
    
    
    
    _textView.attributedText = attributedString;
    
}



@end
