//
//  MessageModel.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel


@property (nonatomic ,strong)AVObject *obj;

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *detail;
@property (nonatomic ,strong)NSString *mark;
@property (nonatomic ,strong)NSString *img_url;
@property (nonatomic ,strong)NSString *url;
@property (nonatomic ,strong)NSString *type;

@property (nonatomic ,strong)NSString *wen_url;

@property (nonatomic ,strong)NSString *content;


- (instancetype)initWithObject:(AVObject*)object ;

+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

@end
