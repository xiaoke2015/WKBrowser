//
//  NetWorkManager.m
//  ExtendDemo
//
//  Created by yuyue on 2017/2/9.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "NetWorkManager.h"



@implementation NetWorkManager


// 监控网络状态
+ (void)netWorkMonitoring {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //2. 设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        //        NSLog(@"networkReachabilityStatus =  %ld ", [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
        //
                NSLog(@" monitoring =  %ld ", status );
    }];
    //3. 开始监控
    [manager startMonitoring];
}

// 检测网络状态
+ (BOOL)netWorkEnable {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    BOOL isEnable = YES;
    AFNetworkReachabilityStatus status = manager.networkReachabilityStatus;
    if(status == AFNetworkReachabilityStatusNotReachable || status ==  AFNetworkReachabilityStatusUnknown ) {
        isEnable = NO;
    }

    return isEnable;
}



// 初始化网络请求单例
+ (AFHTTPSessionManager *)shareSessionManager {
    
    //1、创建管理者对象
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
//    if([NetWorkManager netWorkEnable]){
//        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    }
//    else {
//        manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
//    }
    
    manager.requestSerializer.timeoutInterval = 10.f;
    
    NSSet *set = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain",nil];
    manager.responseSerializer.acceptableContentTypes = set;
    
    return manager;
    
}


// post 请求
+ (void)netWorkPostURL:(NSString*)urlString
        parameters:(NSDictionary*)parameters
        completion:(NetWorkBlock)successBlock {
    
    
    static int i = 0;
    
    [NetWorkManager printGetURL:urlString parameters:parameters];
    
    [HUDManager alertLoading];
    //1、创建管理者对象
    AFHTTPSessionManager * manager = [NetWorkManager shareSessionManager];
    
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * responseDict = responseObject;
        NSLog(@"%@",responseDict);
        
        [HUDManager alertHide];
        
        successBlock(responseDict);
        
        
        NSLog(@"%@ +++ %@",urlString , @(i));
        i++;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@ parameters = %@",urlString,parameters);
        
        [HUDManager alertHide];
        
        if(error != nil){
            [HUDManager alertText:@"服务器错误!"];
        }
        
        NSLog(@"%@ --- %@",urlString , @(i));

        i++;
    }];
    
    
}




// get 请求
+ (void)netWorkGetURL:(NSString *)urlString
        parameters:(NSDictionary *)parameters
        completion:(NetWorkBlock)successBlock {
    
    [NetWorkManager printGetURL:urlString parameters:parameters];
    
    [HUDManager alertLoading];
    //1、创建管理者对象
    AFHTTPSessionManager * manager = [NetWorkManager shareSessionManager];
    
    [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [HUDManager alertHide];
        NSDictionary * responseDict = responseObject;
        NSLog(@"%@",responseDict);
        successBlock(responseDict);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [HUDManager alertHide];
        if(error != nil){
            [HUDManager alertText:@"服务器错误!"];
        }
    }];
    
}




// post 请求上传图片
+ (void)netWorkPostURL:(NSString*)urlString
        parameters:(NSDictionary*)parameters
          imgArray:(NSArray *)imgArray
       imgKeyArray:(NSArray *)imgKeyArray
        completion:(NetWorkBlock)successBlock {
    
    //1、创建管理者对象
    AFHTTPSessionManager * manager = [NetWorkManager shareSessionManager];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    //2、上传文件
        for(int i=0;i<imgArray.count;i++) {
            
            UIImage *img = imgArray[i];
            NSString *file = imgKeyArray[i];
            NSData*imageData = UIImageJPEGRepresentation(img, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:imageData name:file fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * responseDict = responseObject;
        NSData *data =  [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        
        successBlock(responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(error != nil){
            [HUDManager alertText:@"服务器错误!"];
        }
    }];
    
}



// post 请求上传图片
+ (void)netWorkPostURL:(NSString*)urlString
            parameters:(NSDictionary*)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
            completion:(NetWorkBlock)successBlock {
    
    [NetWorkManager printGetURL:urlString parameters:parameters];

    
    [HUDManager alertLoading];
    //1、创建管理者对象
    AFHTTPSessionManager * manager = [NetWorkManager shareSessionManager];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        block(formData);
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * responseDict = responseObject;
        NSData *data =  [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        [HUDManager alertHide];
        
        successBlock(responseDict);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [HUDManager alertHide];
        
        if(error != nil){
            [HUDManager alertText:@"服务器错误!"];
        }
    }];
    
}



// 打印URL
+ (void)printGetURL:(NSString*)url parameters:(NSDictionary*)parameters {
    
    NSString *str = @"";
    
    NSArray*array = [parameters allKeys];
    
    for(int i=0;i<array.count;i++) {
        
        NSString *text = [NSString stringWithFormat:@"%@=%@",array[i] ,parameters[array[i]]];
        str = [str stringByAppendingString:text];
        
        if(i<array.count-1){
            str = [str stringByAppendingString:@"/"];
        }
    }
    
    url = [url stringByAppendingString:@"?"];
    url = [url stringByAppendingString:str];
    
    NSLog(@"url = %@",url);
    
    
//    NSInteger totalRecord = 10;
//    NSInteger maxResult = 10;
//    NSInteger totalPage = (totalRecord + maxResult -1) / maxResult;
    
}




+ (void)clearCache {
    
    SDImageCache *sdimagecache = [SDImageCache sharedImageCache];
    
    [sdimagecache clearMemory];
    
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];

    [HUDManager alertText:@"清除缓存成功!"];
    
}




@end
