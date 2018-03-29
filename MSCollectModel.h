//
//  MSCollectModel.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/16.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

#import "MessageModel.h"

@interface MSCollectModel : BaseModel

@property (nonatomic ,strong)AVObject *obj;


@property (nonatomic ,strong)MessageModel *message;

- (instancetype)initWithObj:(AVObject*)obj ;

// 获取帮助列表
+ (void)findUserObjects:(MDArrayResultBlock)resultBlock;


+ (void)addCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block ;

+ (void)delCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block ;

+ (void)delCollect:(MSCollectModel*)model block:(AVBooleanResultBlock)block ;

+ (void)isCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block ;

@end
