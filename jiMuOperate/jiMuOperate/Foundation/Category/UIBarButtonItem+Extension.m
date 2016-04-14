//
//  UIBarButtonItem+Extension.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action transformAngle:(CGFloat)angle
{
    UIButton *button = [[UIButton alloc] init];
//    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    CGRect tempRect1;
//    if (angle) {
//        button.transform = CGAffineTransformMakeRotation(angle);
//        
//        tempRect1 = CGRectMake(0, 10, 40, 50);
//    }else{
//        
//        tempRect1 = CGRectMake(0, -10, 40, 50);
//    }
     // 设置按钮的尺寸为背景图片的尺寸
    CGRect tempRect = CGRectMake(0, 0, 30, 30);
    
    CGRect tempRect1 = CGRectMake(0, -10, 30, 40);
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:tempRect1];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image = [UIImage imageNamed:imageName];
    imgView.userInteractionEnabled = NO;
    [button addSubview:imgView];
    
    button.frame = tempRect;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
