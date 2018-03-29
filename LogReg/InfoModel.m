//
//  InfoModel.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/21.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoModel.h"

static NSString * modelKey = @"info";

@implementation InfoModel



- (instancetype)initWithObject:(AVObject *)object {
    
    self = [super init];
    
    
    self.objectId = [object objectForKey:@"objectId"];
    
    self.user_id = [object objectForKey:@"user_id"];
    self.sex = [object objectForKey:@"sex"];
    self.content = [object objectForKey:@"content"];
    self.user_name = [object objectForKey:@"user_name"];
//    self.user_avatar = [object objectForKey:@"user_avatar"];
    
    
    AVFile *file = [object objectForKey:@"image"];
    
    if(file.url != nil){
        
        self.user_avatar = file.url;
    }
    else {
        self.user_avatar = @"";
    }
    
    return self;
}




+ (void)editName:(NSString *)name  success:(ActionBlock) resultBlock {
    
    AVUser *user = [AVUser currentUser];
    
    [user setObject:name forKey:@"name"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded == YES){
            
            [HUDManager alertText:@"保存成功"];
            
            resultBlock();
        }
        else {
            [HUDManager alertText:@"保存失败"];
        }
    }];
    
}


+ (void)editSex:(NSString *)sex  success:(ActionBlock) resultBlock {
    
    AVUser *user = [AVUser currentUser];
    
    [user setObject:sex forKey:@"sex"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded == YES){
            
            [HUDManager alertText:@"保存成功"];
            
            resultBlock();
        }
        else {
            [HUDManager alertText:@"保存失败"];
        }
    }];
}


+ (void)editImgae:(UIImage *)image  success:(ActionBlock) resultBlock {
    
    
    NSData*imageData  = UIImageJPEGRepresentation(image, 0.5);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@0%@.jpg", str,@(02)];
    
    AVFile *file = [AVFile fileWithName:fileName data:imageData];
    
    AVUser *user = [AVUser currentUser];
    
    [user setObject:file forKey:@"avatar"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
       
        if(succeeded == YES){
            
            [HUDManager alertText:@"保存成功"];
            
            resultBlock();
        }
        else {
            [HUDManager alertText:@"保存失败"];
        }
    }];
}



+ (void)editDetail:(NSString *)detail  success:(ActionBlock) resultBlock {
    
    AVUser *user = [AVUser currentUser];
    
    [user setObject:detail forKey:@"detail"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded == YES){
            
            [HUDManager alertText:@"保存成功"];
            
            resultBlock();
        }
        else {
            [HUDManager alertText:@"保存失败"];
        }
    }];
}


+ (void)findArray:(NSArray *)array success:(MDArrayResultBlock)resultBlock {
    
    
    AVQuery *query = [AVQuery queryWithClassName:modelKey];
    
    //    [query orderByDescending:@"updatedAt"];
    
    [query whereKey:@"user_id" containedIn:array];

    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            InfoModel *model = [[InfoModel alloc]initWithObject:obj];
            [models addObject:model];
        }
        
        resultBlock(models,error);
        
    }];
}



@end
