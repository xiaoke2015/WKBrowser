//
//  ItemModel.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface ItemModel : BaseModel

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *img_url;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *price;
@property (nonatomic ,strong)NSString *date;

@property (nonatomic ,strong)NSString *detail;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *lat;
@property (nonatomic ,strong)NSString *lng;
@property (nonatomic ,strong)NSString *nums;
@property (nonatomic ,strong)NSString *style;
@property (nonatomic ,strong)NSString *hot;


// 后台开关
@property (nonatomic ,strong)NSString *bid;
@property (nonatomic ,strong)NSString *url;


+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

@end
