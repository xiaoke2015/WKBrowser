//
//  MSCommentModel.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/16.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MSCommentModel.h"

@implementation MSCommentModel


- (instancetype)initWithObj:(AVObject*)obj {
    
    self = [super init];
    
    AVObject *user = [obj objectForKey:@"user_id"];
    
    user = [user fetchIfNeededWithKeys:user.allKeys error:nil];
    
    AVObject *message = [obj objectForKey:@"message"];
    
    message = [message fetchIfNeededWithKeys:message.allKeys error:nil];
    
    self.message = [[MessageModel alloc]initWithObject:message];
    
    self.user_name = [user objectForKey:@"name"];
    
    self.content = [obj objectForKey:@"content"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.creatAt = [dateFormatter stringFromDate:user.updatedAt];
        
    AVFile *file = [user objectForKey:@"avatar"];
    
    if(file.url != nil){
        
        self.user_avatar = file.url;
    }
    else {
        self.user_avatar = @"";
    }
    
    
    
    return self;
}




+ (void)addCollectWithModel:(MessageModel*)model block:(AVBooleanResultBlock)block {
    
    AVUser *user = [AVUser currentUser];
    
    if(user == nil){
        [HUDManager alertText:@"请登录"];
        return;
    }
    
    AVObject *obj = [AVObject objectWithClassName:@"comment"];
    
    [obj setObject:user forKey:@"user_id"];
    [obj setObject:model.obj forKey:@"message"];
    [obj setObject:model.content forKey:@"content"];
    
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        block (succeeded ,error);
        
    }];
    
}



// 获取帮助列表
+ (void)findUserObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"comment"];
    
    AVUser *user = [AVUser currentUser];

    [query whereKey:@"user_id" equalTo:user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            //收藏模型
            AVObject *obj = objects[i];
            
            MSCommentModel *model = [[MSCommentModel alloc]initWithObj:obj];
            
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}


// 获取帮助列表
+ (void)findMessage:(MessageModel*)model  Objects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"comment"];
    
    [query whereKey:@"message" equalTo:model.obj];
    
    [query orderByDescending:@"updateAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            //收藏模型
            AVObject *obj = objects[i];
            
            MSCommentModel *model = [[MSCommentModel alloc]initWithObj:obj];
            
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}






@end
