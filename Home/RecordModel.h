//
//  RecordModel.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface RecordModel : BaseModel

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *url;
@property (nonatomic ,strong)NSString *date;

@end
