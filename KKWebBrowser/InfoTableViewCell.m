//
//  InfoTableViewCell.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

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
    
    self.imageView.frame = CGRectMake(15, self.height/2 - 12, 24, 24);
    
    self.textLabel.frame = CGRectMake(60, self.height/2 - 15, SCREEM_WIDTH - 120, 30);
    
}

@end
