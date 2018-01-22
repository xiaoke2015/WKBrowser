//
//  MessageModel.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel





- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super initWithDict:nil];
    
    self.Id = [object objectForKey:@"objectId"];
    self.mark = [object objectForKey:@"mark"];
    //title
    self.title = [object objectForKey:@"title"];
   
    self.url = [object objectForKey:@"url"];
    self.detail = [object objectForKey:@"detail"];
    
    
    AVFile *file = [object objectForKey:@"img"];
    

    
    if(file.url != nil){
        
        self.img_url = file.url;
    }
    else {
        self.img_url = @"";
    }
    
    
    return self;
}





+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"message"];
    
    [query orderByDescending:@"updatedAt"];
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            
            AVObject *obj = objects[i];
            MessageModel *model = [[MessageModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
    
    
//    NSString *cql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY RAND() LIMIT ", @"message"];
//    
//    [AVQuery doCloudQueryInBackgroundWithCQL:cql callback:^(AVCloudQueryResult *result, NSError *error)
//     {
//         NSLog(@"results:%@", result.results);
//         
//         NSArray * objects = result.results;
//         
//         NSMutableArray *models = [NSMutableArray array];
//         
//         for(int i=0;i<objects.count;i++){
//             
//             
//             AVObject *obj = objects[i];
//             MessageModel *model = [[MessageModel alloc]initWithObject:obj];
//             [models addObject:model];
//             
//         }
//         
//         resultBlock(models,error);
//     }];
    
    
}



@end
