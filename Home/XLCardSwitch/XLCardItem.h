//
//  CardModel.h
//  CardSwitchDemo
//
//  Created by Apple on 2017/1/6.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WKBrowserViewController.h"

@interface XLCardItem : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) WKBrowserViewController * pageVC;

@end
