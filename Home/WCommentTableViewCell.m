//
//  WCommentTableViewCell.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WCommentTableViewCell.h"

@interface WCommentTableViewCell ()

@property  (nonatomic ,strong)UILabel *name;

@property  (nonatomic ,strong)UILabel *date;

@property  (nonatomic ,strong)UILabel *context;

@property  (nonatomic ,strong)UIImageView *imgView;

@end

@implementation WCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.height/2;
    _imgView.image = [UIImage imageNamed:@"avatar"];
    [self.contentView addSubview:_imgView];
    
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, SCREEM_WIDTH - 75, 20)];
    _name.font = FONT14;
    _name.textColor = RGB(100, 100, 100);
    [self.contentView addSubview:_name];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, SCREEM_WIDTH - 75, 20)];
    _date.font = FONT12;
    _date.textColor = RGB(200, 200, 200);
    [self.contentView addSubview:_date];
    
    _context = [[UILabel alloc]initWithFrame:CGRectMake(60, 60, SCREEM_WIDTH - 75, 20)];
    _context.textColor = RGB(0, 0, 0);
    _context.numberOfLines = 0;
    _context.font = FONT15;
    [self.contentView addSubview:_context];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _context.bottom +10);
}




- (void)dataWithModel:(MSCommentModel *)model {
    
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.user_avatar] placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    _name.text = _model.user_name;
    _date.text = _model.creatAt;
    
    _context.frame = CGRectMake(60, 60, SCREEM_WIDTH - 75, 20);
    _context.text = _model.content;
    
    [_context sizeToFit];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _context.bottom +10);
}



@end
