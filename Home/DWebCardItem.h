//
//  DWebCardItem.h
//  WKBrowser
//
//  Created by 李加建 on 2017/11/8.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWebCardItem : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) WKBrowserViewController * pageVC;

@end
