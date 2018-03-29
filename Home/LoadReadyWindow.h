//
//  LoadReadyWindow.h
//  圆的放大动画效果
//
//  Created by limin on 17/5/7.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadReadyWindow : UIWindow<CAAnimationDelegate>


@property (nonatomic ,strong)UIImageView *presentView;
@property(nonatomic ,assign)CGRect startFrame;
- (id)initWithFrame:(CGRect)frame imageName:(NSString*)name;
-(void)makeOuttoAnimation;
/* 动画结束后的操作 */
@property(nonatomic,copy)void(^animationStopOperation)();
@end
