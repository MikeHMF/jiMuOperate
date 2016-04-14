//
//  JTSlideShadowAnimation.m
//  JTSlideShadowAnimation
//
//  Created by Jonathan Tribouharet
//

#import "JTSlideShadowAnimation.h"

@interface JTSlideShadowAnimation(){
    CABasicAnimation *currentAnimation;
}

@end

@implementation JTSlideShadowAnimation

- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    self.shadowBackgroundColor = [UIColor colorWithWhite:1. alpha:.3];
    self.shadowForegroundColor = [UIColor whiteColor];
    
    self.shadowWidth = 20.;
    self.repeatCount = HUGE_VALF;
    self.duration = 3.;
}

- (void)start
{
    if(!self.animatedView){
        NSLog(@"JTSlideShadowAnimation no view to animate");
        return;
    }
    
    [self stop];
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.animatedView.bounds;
    
    CGFloat gradientSize = self.shadowWidth / self.animatedView.frame.size.width;
    
    NSArray *startLocations = @[
                                @0,
                                [NSNumber numberWithFloat:(gradientSize / 2.)],
                                [NSNumber numberWithFloat:gradientSize]
                                ];
    NSArray *endLocations = @[
                              [NSNumber numberWithFloat:(1. - gradientSize)],
                              [NSNumber numberWithFloat:(1. - (gradientSize / 2.))],
                              @1
                              ];
    
    
    gradientMask.colors = @[
                            (id)self.shadowBackgroundColor.CGColor,
                            (id)self.shadowForegroundColor.CGColor,
                            (id)self.shadowBackgroundColor.CGColor
                            ];
    gradientMask.locations = startLocations;
    gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), .5);
    gradientMask.endPoint = CGPointMake(1 + gradientSize, .5);
    
    self.animatedView.layer.mask = gradientMask;
    
    currentAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    currentAnimation.fromValue = startLocations;
    currentAnimation.toValue = endLocations;
    currentAnimation.repeatCount = self.repeatCount;
    currentAnimation.duration  = self.duration;
    currentAnimation.delegate = self;
    
    [gradientMask addAnimation:currentAnimation forKey:@"JTSlideShadowAnimation"];
}

- (void)stop
{
    if(self.animatedView && self.animatedView.layer.mask){
        [self.animatedView.layer.mask removeAnimationForKey:@"JTSlideShadowAnimation"];
        self.animatedView.layer.mask = nil;
        currentAnimation = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished
{
    if(anim == currentAnimation){
        [self stop];
    }
}

+ (JTSlideShadowAnimation *)allocWithAnimatedView:(UIView *)animatedView Start:(BOOL)isStart
{
    JTSlideShadowAnimation *shadowAnimation = [JTSlideShadowAnimation new];
    shadowAnimation.animatedView = animatedView;
    shadowAnimation.shadowWidth = 20.;
    int numb = (arc4random()*5) %4;
    int numb2 = (arc4random()*5) %4;
    shadowAnimation.duration = numb2 * 2 + 4;
    
    [JTSlideShadowAnimation slideAViewAryMAddV:animatedView];
    if (isStart) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(numb * 0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [shadowAnimation start];
        });
    }
    return shadowAnimation;
}

//当前登录用户的信息 为单例模式
+(instancetype)shardSlideAnimation
{
    static dispatch_once_t pred;
    static JTSlideShadowAnimation *currentSlideAni;
    dispatch_once(&pred, ^{
        currentSlideAni = [[JTSlideShadowAnimation alloc] init];
        
    });
    return currentSlideAni;
}

+ (void)stateAllAnimation
{
    NSMutableArray *aryM = [JTSlideShadowAnimation shardSlideAnimation].slideAViewAryM;
    for (UIImageView *imageV in aryM) {
        JTSlideShadowAnimation *shadowAnimation = [JTSlideShadowAnimation new];
        shadowAnimation.animatedView = imageV;
        shadowAnimation.shadowWidth = 20.;
        int numb2 = (arc4random()*5) %4;
        shadowAnimation.duration = numb2 * 2 + 4;
        [shadowAnimation start];
    }
    
}

+ (void)stopAllAnimation
{
    NSMutableArray *aryM = [JTSlideShadowAnimation shardSlideAnimation].slideAViewAryM;
    for (UIImageView *imageV in aryM) {
        JTSlideShadowAnimation *shadowAnimation = [JTSlideShadowAnimation new];
        if (shadowAnimation.animatedView == imageV) {
            [shadowAnimation stop];
        }
    }

}

+ (BOOL)slideAViewAryMAddV:(UIView *)imgV1
{
    NSMutableArray *aryM = [JTSlideShadowAnimation shardSlideAnimation].slideAViewAryM;
    if (!aryM) {
        aryM = [NSMutableArray array];
    }
    BOOL isHave = NO;
    for (UIImageView *imageV in aryM) {
        if ([imageV isEqual:imgV1]) {
            isHave = YES;
            break;
        }
    }
    if (!isHave) {
        [aryM addObject:imgV1];
    }
    [JTSlideShadowAnimation shardSlideAnimation].slideAViewAryM = aryM;
    return isHave;
}

@end

