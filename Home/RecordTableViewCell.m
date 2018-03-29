//
//  RecordTableViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/8.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

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
    
    
    self.imageView.image = [UIImage imageNamed:@"web_brower"];
    
    _collBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [_collBtn setImage:[UIImage imageNamed:@"search_page"] forState:UIControlStateNormal];
    
//    self.accessoryView = _collBtn;
    
    
    [_collBtn addTarget:self action:@selector(collBtnAction) forControlEvents:UIControlEventTouchDragExit];
}



- (void)collBtnAction {
    
    
}


@end
