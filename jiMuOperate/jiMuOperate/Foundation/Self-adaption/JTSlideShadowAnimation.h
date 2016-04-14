//
//  JTSlideShadowAnimation.h
//  JTSlideShadowAnimation
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@interface JTSlideShadowAnimation : NSObject

@property (weak, nonatomic) UIView *animatedView;

@property (strong, nonatomic) UIColor *shadowBackgroundColor;
@property (strong, nonatomic) UIColor *shadowForegroundColor;
@property (assign, nonatomic) CGFloat shadowWidth;
@property (assign, nonatomic) CGFloat repeatCount;
@property (assign, nonatomic) NSTimeInterval duration;

- (void)start;
- (void)stop;

+ (JTSlideShadowAnimation *)shardSlideAnimation;
/**初始化JTSlideShadowAnimation
 * animatedView 要滑光的view
 * isStart 是否自动开启
 */
+ (JTSlideShadowAnimation *)allocWithAnimatedView:(UIView *)animatedView Start:(BOOL)isStart;
/*开启所以的滑光*/
+ (void)stateAllAnimation;
+ (void)stopAllAnimation;

/**关于slide动画的view slideAView模型**/
@property(strong,nonatomic) NSMutableArray *slideAViewAryM;
+ (BOOL)slideAViewAryMAddV:(UIView *)imgV1;

@end
