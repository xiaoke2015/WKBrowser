//
//  InfoModel.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/21.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface InfoModel : BaseModel

@property (nonatomic ,strong)NSString * objectId;
@property (nonatomic ,strong)NSString * user_id;
@property (nonatomic ,strong)NSString * article_id;
@property (nonatomic ,strong)NSString * content;

@property (nonatomic ,strong)NSString * user_name;
@property (nonatomic ,strong)NSString * user_avatar;
@property (nonatomic ,strong)NSString * sex;



+ (void)editName:(NSString *)name  success:(ActionBlock) resultBlock ;

+ (void)editSex:(NSString *)sex  success:(ActionBlock) resultBlock ;

+ (void)editImgae:(UIImage *)image  success:(ActionBlock) resultBlock ;

+ (void)editDetail:(NSString *)detail  success:(ActionBlock) resultBlock ;



+ (void)findArray:(NSArray *)array success:(MDArrayResultBlock)resultBlock  ;


@end
