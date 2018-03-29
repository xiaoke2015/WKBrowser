//
//  MSCommentModel.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/16.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

#import "MessageModel.h"

@interface MSCommentModel : BaseModel

@property (nonatomic ,strong)NSString *user_name;
@property (nonatomic ,strong)NSString *user_avatar;

@property (nonatomic ,strong)NSString *creatAt;
@property (nonatomic ,strong)NSString * content;


@property (nonatomic ,strong)AVObject *obj;

@property (nonatomic ,strong)MessageModel *message;

- (instancetype)initWithObj:(AVObject*)obj ;

+ (void)addCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block ;

+ (void)findMessage:(MessageModel*)model  Objects:(MDArrayResultBlock)resultBlock  ;

+ (void)findUserObjects:(MDArrayResultBlock)resultBlock ;

@end
