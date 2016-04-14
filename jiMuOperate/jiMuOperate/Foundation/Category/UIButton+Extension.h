//
//  UIButton+Extension.h
//  UnionRich
//
//  Created by 云天 on 15/4/27.
//  Copyright (c) 2015年 cgc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(Extension)
/**
 *  创建默认图片的按钮
 *
 *  @param title 标题
 *  @param frame 位置
 */
- (UIButton *)initWithTitle:(NSString *)title withFrame:(CGRect )rect1;
/**
 *  创建默认图片的按钮
 *
 *  @param title 标题
 *  @param buttonY 默认在正中间
 */
- (UIButton *)initWithImage:(NSString *)name withHeightImage:(NSString *)nameHeight;
@end
