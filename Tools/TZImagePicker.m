//
//  TZImagePicker.m
//  Aladdin
//
//  Created by yuyue on 2017/3/8.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "TZImagePicker.h"

#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"



@interface TZImagePicker ()<TZImagePickerControllerDelegate>




@end

@implementation TZImagePicker







+ (void)pickerImageWithVC:(UIViewController *)vc
           selectedAssets:(NSMutableArray *)selectedAssets
              handleBlcok:(didFinishPickingPhotosHandle )handleBlcok {
    
    
    TZImagePickerController *imagePicker = [[TZImagePickerController  alloc]initWithMaxImagesCount:8 delegate:nil];
    
    imagePicker.isSelectOriginalPhoto = NO;
    
    imagePicker.selectedAssets = selectedAssets;
    
    imagePicker.allowTakePicture = YES;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePicker = [UIColor greenColor];
    // imagePicker = [UIColor lightGrayColor];
    // imagePicker = [UIColor greenColor];
    
    imagePicker.allowPickingVideo = NO;
    imagePicker.allowPickingImage = YES;
    
    // 4. 照片排列按修改时间升序
    imagePicker.sortAscendingByModificationDate = YES;
    
    
    
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if(photos.count > 0){
            
            handleBlcok(photos , assets);
        }
        
    }];
    
    
    [imagePicker setDidFinishPickingVideoHandle:^(UIImage  *photos, id type) {
        
        
        
    }];
    
    
    [vc presentViewController:imagePicker animated:YES completion:nil];
    
}


+ (void)pickerImageWithVC:(UIViewController *)vc
           count:(NSInteger )count
              handleBlcok:(didFinishPickingPhotosHandle )handleBlcok {
    
    
    TZImagePickerController *imagePicker = [[TZImagePickerController  alloc]initWithMaxImagesCount:count delegate:nil];
    
    imagePicker.isSelectOriginalPhoto = NO;
    
    imagePicker.selectedAssets = nil;
    
    imagePicker.allowTakePicture = YES;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePicker = [UIColor greenColor];
    // imagePicker = [UIColor lightGrayColor];
    // imagePicker = [UIColor greenColor];
    
    imagePicker.allowPickingVideo = NO;
    imagePicker.allowPickingImage = YES;
    
    // 4. 照片排列按修改时间升序
    imagePicker.sortAscendingByModificationDate = YES;
    
    
    
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if(photos.count > 0){
            
            handleBlcok(photos , assets);
        }
        
    }];
    
    
    [imagePicker setDidFinishPickingVideoHandle:^(UIImage  *photos, id type) {
        
        
        
    }];
    
    
    [vc presentViewController:imagePicker animated:YES completion:nil];
    
}




@end
