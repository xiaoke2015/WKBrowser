//
//  WCommentTableViewCell.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSCommentModel.h"

@interface WCommentTableViewCell : UITableViewCell


@property (nonatomic,strong)MSCommentModel *model;


- (void)dataWithModel:(MSCommentModel *)model ;

@end
