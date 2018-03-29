//
//  ZSLImagePicker+TZImagePickerController.h
//  ExtendDemo
//
//  Created by yuyue on 2017/2/13.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "ZSLImagePicker.h"


#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

@interface ZSLImagePicker (TZImagePickerController)<TZImagePickerControllerDelegate>


- (void)TZpickImageWithVC:(UIViewController *)vc ;

@end
