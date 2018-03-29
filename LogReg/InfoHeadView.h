//
//  InfoHeadView.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoHeadView : UIView

@property (nonatomic ,copy)void (^goBlock)(NSInteger tag);

@property (nonatomic ,copy)void (^goBlock1)();

@property (nonatomic ,strong)UILabel *name ;

@property (nonatomic ,strong)UIImageView *imgView;

@end
