//
//  UserManager.m
//  DemoBaseVC
//
//  Created by yuyue on 15-11-10.
//  Copyright (c) 2015年 incredibleRon. All rights reserved.
//

#import "UserManager.h"



//NSString *const LoginNotification = @"LoginNotification";
//NSString *const QuitNotification = @"QuitNotification";

static UserManager *user = nil;


@implementation UserManager

// 登录
+ (void)loginWithToken:(NSString*)token {
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
}

//登录 token
+ (NSString*)getToken {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    return token;
}

// 退出
+ (void)removeToken {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
}



+ (NSString*)isBannaer {
    
    
    NSString* url =  [[NSUserDefaults standardUserDefaults] objectForKey:@"isBanner"];
    
    return url;
}


+ (void)saveBannver:(NSString*)url {
    
    [[NSUserDefaults standardUserDefaults] setObject:url  forKey:@"isBanner"];
}


+ (void)removeBanner {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isBanner"];
}


@end
