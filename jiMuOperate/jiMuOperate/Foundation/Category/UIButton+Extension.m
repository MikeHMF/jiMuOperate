//
//  UIButton+Extension.m
//  UnionRich
//
//  Created by 云天 on 15/4/27.
//  Copyright (c) 2015年 cgc. All rights reserved.
//

//获取屏幕 宽度、高度
#import "UIButton+Extension.h"


@implementation UIButton(Extension)

- (UIButton *)initWithTitle:(NSString *)title withFrame:(CGRect )rect1{
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:rect1];
    
    [button1 setTitle:title forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    
    return button1;
}

- (UIButton *)initWithImage:(NSString *)name withHeightImage:(NSString *)nameHeight
{
    CGFloat bottomBtnH = 70;
    CGFloat bottomBtnW = [UIScreen mainScreen].bounds.size.width;
    CGFloat bottomBtnX = 0;
    CGFloat bottomBtnY = [UIScreen mainScreen].bounds.size.height - bottomBtnH+2;
    CGRect bottomRect = CGRectMake(bottomBtnX, bottomBtnY, bottomBtnW, bottomBtnH);
    UIButton *button = [[UIButton alloc]initWithFrame:bottomRect];
    [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:nameHeight] forState:UIControlStateHighlighted];
    button.contentMode = UIViewContentModeCenter;
    return button;
}
@end
