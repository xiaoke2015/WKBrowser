//
//  SettingsTableViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    self.textLabel.frame = CGRectMake(15, self.height/2 - 15, SCREEM_WIDTH - 30, 30);
    
}

@end
