//
//  TZImagePicker.h
//  Aladdin
//
//  Created by yuyue on 2017/3/8.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^didFinishPickingPhotosHandle)(NSArray *photos ,NSArray* assets);

@interface TZImagePicker : NSObject


+ (void)pickerImageWithVC:(UIViewController *)vc
           selectedAssets:(NSMutableArray *)selectedAssets
              handleBlcok:(didFinishPickingPhotosHandle )handleBlcok ;



+ (void)pickerImageWithVC:(UIViewController *)vc
                    count:(NSInteger )count
              handleBlcok:(didFinishPickingPhotosHandle )handleBlcok;

@end
