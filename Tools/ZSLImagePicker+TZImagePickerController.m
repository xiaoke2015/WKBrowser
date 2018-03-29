//
//  ZSLImagePicker+TZImagePickerController.m
//  ExtendDemo
//
//  Created by yuyue on 2017/2/13.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "ZSLImagePicker+TZImagePickerController.h"





@implementation ZSLImagePicker (TZImagePickerController)




- (void)TZpickImageWithVC:(UIViewController *)vc {
    
    NSInteger maxCount = 9;
    NSInteger columnNumber = 4;
    
    BOOL isSelect = NO;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount columnNumber:columnNumber delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = isSelect;
    
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
    
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    
    
    
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if(self.completion != nil){
            self.completion(photos);
            
            self.selectedAssets = [NSMutableArray arrayWithArray:assets];
        }
        
    }];
    
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage  *photos, id type) {
        
        
        
    }];
    
    
    [vc presentViewController:imagePickerVc animated:YES completion:nil];
}


@end
