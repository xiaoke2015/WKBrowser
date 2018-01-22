//
//  ItemModel.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel




- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super initWithDict:nil];
    
    self.Id = [object objectForKey:@"objectId"];
    self.type = [object objectForKey:@"type"];
    //title
    self.title = [object objectForKey:@"title"];
    self.price = [object objectForKey:@"price"];
    self.date = [object objectForKey:@"date"];
    
    self.detail = [object objectForKey:@"detail"];
    self.nums = [object objectForKey:@"nums"];
    self.address = [object objectForKey:@"address"];
    self.lat = [object objectForKey:@"lat"];
    self.lng = [object objectForKey:@"lng"];
    
    self.style = [object objectForKey:@"style"];
    self.hot = [object objectForKey:@"ishot"];
    
    AVFile *file = [object objectForKey:@"img"];
    
    //url
    self.url = [object objectForKey:@"url"];
    self.bid = [object objectForKey:@"bid"];
    
    if(file.url != nil){
        
        self.img_url = file.url;
    }
    else {
        self.img_url = @"";
    }
    
    
    return self;
}





+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"items"];
    
    //    [query whereKey:@"type" equalTo:@"1"];
    
//    [query whereKey:@"bid" equalTo:BUNDLEID];
    
//    [query orderByDescending:@"updatedAt"];
    [query orderByAscending:@"type"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            
            AVObject *obj = objects[i];
            ItemModel *model = [[ItemModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}




@end
