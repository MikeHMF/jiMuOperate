//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

/**设置偏移*/
-(void)setupMotionEffectWithValueX:(int)valueX ValueY:(int)valueY{
    
    CGFloat mutale = 0.6;
    valueX = mutale*valueX;
    valueY = mutale*valueY;
    //设置偏移
    if (self.motionEffects.count >0) {
        return;
    }
    UIInterpolatingMotionEffect*effectX;
    effectX=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    //设置最大值和最小值
    effectX.maximumRelativeValue=@(valueX);
    effectX.minimumRelativeValue=@(-valueX);
    [self addMotionEffect:effectX];
    
    UIInterpolatingMotionEffect*effectY;
    effectY=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effectY.maximumRelativeValue=@(valueY);
    effectY.minimumRelativeValue=@(-valueY);
    [self addMotionEffect:effectY];

    
}

- (void)addCAEmitterLayerImageName:(NSString *)name
{
    //创建layer
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射点
        snowEmitter.emitterPosition = CGPointMake(self.width / 2.0, self.height/2.0);
//    snowEmitter.emitterSize		= self.frame.size;
    snowEmitter.emitterSize		= CGSizeMake(arc4random()%(int)self.width, arc4random()%(int)self.width);
    //发射模式
    snowEmitter.emitterMode		= kCAEmitterLayerVolume;
    //发射源的形状
    snowEmitter.emitterShape	= kCAEmitterLayerCuboid;
    snowEmitter.renderMode      = kCAEmitterLayerBackToFront;

    // 创建粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    //粒子产生率
    snowflake.birthRate		= 2;
    //粒子生命周期
    snowflake.lifetime		= 50.0;
    //速度值
//    snowflake.velocity		= 10;
    //速度微调值
    snowflake.velocityRange = 60;
    
    snowflake.zAcceleration = 30;
    //发射角度
    snowflake.emissionRange = 2 * M_PI;
    //自旋转速度
    snowflake.spinRange		= 1 * M_PI;
    //name
    snowflake.contents		= (id) [[UIImage imageNamed:name] CGImage];
    snowflake.color			= [[UIColor colorWithRed:0.600 green:0.600 blue:0.600 alpha:0.800] CGColor];
    snowflake.alphaRange = 1.0;
 
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 1.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    //亮光？
//    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    
    
    //添加layer
    [self.layer insertSublayer:snowEmitter atIndex:0];
}


@end
