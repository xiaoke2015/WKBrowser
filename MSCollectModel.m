//
//  MSCollectModel.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/16.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MSCollectModel.h"

@implementation MSCollectModel


- (instancetype)initWithObj:(AVObject*)obj {
    
    self = [super init];
    
    
    AVObject *message = [obj objectForKey:@"message"];
    
    message = [message fetchIfNeededWithKeys:message.allKeys error:nil];
    
    self.message = [[MessageModel alloc]initWithObject:message];
    
    return self;
}



+ (void)addCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block {
    
    AVUser *user = [AVUser currentUser];
    
    if(user == nil){
        [HUDManager alertText:@"请先登录"];
        return;
    }
    
    AVObject *obj = [AVObject objectWithClassName:@"collect"];
    
    [obj setObject:user forKey:@"user_id"];
    [obj setObject:model.obj forKey:@"message"];
    
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        block (succeeded ,error);
        
    }];
    
}

+ (void)delCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block {
    
    AVUser *user = [AVUser currentUser];
    
    if(user == nil){
        [HUDManager alertText:@"请先登录"];
        return;
    }
    
    AVQuery *query = [AVQuery queryWithClassName:@"collect"];
    
    [query whereKey:@"user_id" equalTo:user];
    [query whereKey:@"message" equalTo:model.obj];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        
        if(objects.count > 0){
            
            AVObject *obj = objects[0];
            
            [obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                
                block(succeeded ,error);
            }];
        }
        
    }];

    
}


+ (void)isCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block {
    
    AVUser *user = [AVUser currentUser];
    
    if(user == nil){
//        [HUDManager alertText:@"请先登录"];
        return;
    }
    
    AVQuery *query = [AVQuery queryWithClassName:@"collect"];
    
    [query whereKey:@"user_id" equalTo:user];
    [query whereKey:@"message" equalTo:model.obj];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        
        if(objects.count > 0){
            
            block(YES ,nil);
        }
        else {
            
            block(NO ,nil);
        }
        
    }];
    
    
}



+ (void)delCollect:(MSCollectModel*)model block:(AVBooleanResultBlock)block {
    
    AVUser *user = [AVUser currentUser];
    
    if(user == nil){
        return;
    }
    
    AVObject *obj = model.obj;
    
    [obj deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        block(succeeded ,error);
    }];
    
    
}



// 获取帮助列表
+ (void)findUserObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"collect"];
    
    AVUser *user = [AVUser currentUser];
    
    [query whereKey:@"user_id" equalTo:user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            //收藏模型
            AVObject *obj = objects[i];
            
            MSCollectModel *model = [[MSCollectModel alloc]initWithObj:obj];
            
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}



@end
