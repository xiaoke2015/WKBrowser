//
//  HomeTableViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

@property (nonatomic ,strong)UIButton *btn;

@property (nonatomic ,strong)UIButton *btn1;
@property (nonatomic ,strong)UIButton *btn2;
@property (nonatomic ,strong)UIButton *btn3;
@property (nonatomic ,strong)UIButton *btn4;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = NO;
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    
}

@end
