//
//  MessageTableViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MessageTableViewCell.h"


@interface MessageTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *mark;


@end

@implementation MessageTableViewCell

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
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 90);
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 115, 10, 100, 70)];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imgView];
    
 
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEM_WIDTH - 140, 20)];
    _title.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    _title.numberOfLines = 2;
    //    _title.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    _mark = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, SCREEM_WIDTH - 140, 20)];
//    _mark.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_mark];
    _mark.font = FONT14;
    _mark.font = [UIFont fontWithName:@"Helvetica" size:14];
    _mark.textColor = GRAY200;
    
    
}



- (void)dataWithModel:(MessageModel*)model {
    
    _title.text = model.title;
    _mark.text = model.mark;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];

    
    
    
    _title.frame = CGRectMake(15, 10, SCREEM_WIDTH - 30, 20);
    
    [_title sizeToFit];
    _title.frame = CGRectMake(15, 10, SCREEM_WIDTH - 30, _title.height);
    
    _imgView.frame = CGRectMake(15, _title.bottom+10, SCREEM_WIDTH - 30, (SCREEM_WIDTH - 30)*0.4);
    _mark.frame = CGRectMake(15, _imgView.bottom +10, SCREEM_WIDTH - 30, 20);
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _mark.bottom +10);
    
}


@end
