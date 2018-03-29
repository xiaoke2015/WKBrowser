//
//  ConfMacro.h
//  MBDemo
//
//  Created by yuyue on 2017/5/5.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#ifndef ConfMacro_h
#define ConfMacro_h



//服务器地址

#import "WKSearchBarView.h"


#define HOST @""

#define HOSTAPIKEY(key) [HOST stringByAppendingString:key]

typedef void (^ActionBlock)();

#define DictStr(dict ,key) [NSString stringWithFormat:@"%@",(dict[key]==nil?@"":dict[key])]


// 颜色
#define GRAYCOLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]






#endif /* ConfMacro_h */
