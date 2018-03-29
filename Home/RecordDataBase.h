//
//  RecordDataBase.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RecordModel.h"

@interface RecordDataBase : NSObject

- (void)insertTableWithTitle:(NSString*)title
                         url:(NSString*)url;



- (void)queryLineData:(MDArrayResultBlock)resultBlock ;


- (void)delWithBillId:(NSString*)Id ;


- (void)delAll ;


- (void)addColl:(RecordModel *)model ;


- (void)delColl:(RecordModel *)model ;

// 收藏列表
- (void)queryCollData:(MDArrayResultBlock)resultBlock ;


- (void)insertCollWithTitle:(NSString*)title
                        url:(NSString*)url;


- (void)delCollAll ;

@end
