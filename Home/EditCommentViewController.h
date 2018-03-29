//
//  EditCommentViewController.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "MessageModel.h"

@interface EditCommentViewController : BaseViewController

@property (nonatomic ,copy)ActionBlock success;

@property (nonatomic ,strong)MessageModel *model;

@end
