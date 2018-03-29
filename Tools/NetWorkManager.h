//
//  NetWorkManager.h
//  ExtendDemo
//
//  Created by yuyue on 2017/2/9.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//


// AFNetwork 3.0 以上使用
// iOS 8.0 以上使用
//


#import <Foundation/Foundation.h>


#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>


typedef void(^NetWorkBlock )(NSDictionary * dict);

typedef void(^NetWorkEnable )(BOOL isEnable);

@interface NetWorkManager : NSObject

/*
 * 开启网络监控
 
 */
+ (void)netWorkMonitoring;


/*
 * 检测网络状态
 @return 当前是否有网络
 */
+ (BOOL)netWorkEnable;


/*
 * 网络请求 post
 @program 请求地址
 @program 设置请求参数
 @program 网络请求返回json block
 */
+ (void)netWorkPostURL:(NSString *)urlString
        parameters:(NSDictionary *)parameters
        completion:(NetWorkBlock )successBlock ;

/*
 * 网络请求 get
 @program 请求地址
 @program 设置请求参数
 @program 网络请求返回json block
 */
+ (void)netWorkGetURL:(NSString *)urlString
       parameters:(NSDictionary *)parameters
       completion:(NetWorkBlock )successBlock ;


// post 请求 上传图片
+ (void)netWorkPostURL:(NSString*)urlString
        parameters:(NSDictionary*)parameters
          imgArray:(NSArray *)imgArray
       imgKeyArray:(NSArray *)imgKeyArray
        completion:(NetWorkBlock)successBlock ;

/*
 * 网络请求 上传文件
 @program 请求地址
 @program 设置请求参数
 @program afnetworking 上传文件block
 @program 网络请求返回json block
 */
+ (void)netWorkPostURL:(NSString*)urlString
            parameters:(NSDictionary*)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
            completion:(NetWorkBlock)successBlock;


/*
 * 清除网络缓存

 */
+ (void)clearCache ;

@end
