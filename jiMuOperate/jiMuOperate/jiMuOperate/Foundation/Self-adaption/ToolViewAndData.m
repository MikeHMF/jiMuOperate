//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import "ToolViewAndData.h"
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define fullScreen [UIScreen mainScreen].bounds.size

#define UIColorRGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define UIColorRGBA(r, g, b, a) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define iPhone4s CGRectMake(0, 0, 320, 480)
#define iPhone5s CGRectMake(0, 0, 320, 568)
#define iPhone6 CGRectMake(0, 0, 375, 667)
#define iPhone6Plus CGRectMake(0, 0, 414, 736)

#define NaAndTaHeight (self.navigationController.navigationBar.frame.size.height + self.tabBarController.tabBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height)
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height
#define kTabBarHeight self.tabBarController.tabBar.frame.size.height
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define kFrameControllerView CGRectMake(0, 0, kFrame.size.width, self.view.frame.size.height - NaAndTaHeight)
// 主页面文字的自适应
#define kHomepageLimitHeight 0
#define khomepageLableWidth  265
#define khomgePageFontSige  15.0f
#define kSetRollTime 1.5


static ToolViewAndData *toolViewAndData;

@interface ToolViewAndData ()

@end

@implementation ToolViewAndData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


+ (ToolViewAndData *)shareToolViewAngData
{
  static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!toolViewAndData) {
            toolViewAndData = [[ToolViewAndData alloc] init];
        }
    });
    return toolViewAndData;
}



+ (UIButton *)addBtn:(CGRect)frame title:(NSString *)title backImage:(NSString *)image{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setExclusiveTouch:YES];
    btn.showsTouchWhenHighlighted = YES;
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)btnWithFrame: (CGRect)frane andTitle:(NSString *)title andTitleFont: (CGFloat)fontFloat
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frane];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5.0;
   // [btn setTintColor:tintColor];
    btn.tintColor = [UIColor blackColor];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor
                           ];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontFloat];
    return btn;
}

+ (UIButton *)footer:(CGRect)frame
{
    UIButton *footerBtn = [[UIButton alloc] initWithFrame:frame];
    [footerBtn setExclusiveTouch:YES];
    [footerBtn setTitle:@"清除历史" forState:UIControlStateNormal];
    footerBtn.backgroundColor = [UIColor whiteColor];
    [footerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return footerBtn;
}

#pragma mark   search view search path
- (UIView *)searchPathWithFrame:(CGRect)frame
{
    UIView *searchView = [[UIView alloc] initWithFrame:frame];
    self.searchTextField  = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/15*14, frame.size.height)];
    _searchTextField.layer.cornerRadius = 10;
    _searchTextField.placeholder = @"查找诊所、牙医、护理用品";
    _searchTextField.backgroundColor = [UIColor grayColor];
    [searchView addSubview:_searchTextField];
    
    self.searchSoundBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_searchTextField.frame), 0, frame.size.width/15, CGRectGetHeight(frame))];
    _searchSoundBtn.backgroundColor = [UIColor redColor];
    [_searchSoundBtn addTarget:self action:@selector(searchSoundBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:_searchSoundBtn];
    return searchView;
}

- (void)searchSoundBtnAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(searchSoundBtnAction:)]) {
        [_delegate searchSoundBtnAction:sender];
    }
}
#pragma mark 根据View返回frame
+ (CGRect)MyAutoLayout:(UIView *)aView
{
    CGRect rect = aView.frame;
        if (fullScreen.height == 568) {
            rect.size.height = aView.frame.size.height;
            rect.origin.y = aView.frame.origin.y;
        }else{
            rect.size.height = aView.frame.size.height/iPhone5s.size.height*fullScreen.height;
            rect.origin.y = aView.frame.origin.y/iPhone5s.size.height*fullScreen.height;
        }
        rect.size.width = aView.frame.size.width/iPhone5s.size.width*fullScreen.width;
        rect.origin.x = aView.frame.origin.x/iPhone5s.size.width*fullScreen.width;
    return rect;
}


+ (CGSize)autoLayoutSize: (UICollectionViewFlowLayout *)flowlayout
{
    CGSize size = flowlayout.itemSize;
    if (fullScreen.height == 568) {
        size.height = flowlayout.itemSize.height;
        size.width = flowlayout.itemSize.width;
    }else{
        size.width = flowlayout.itemSize.width/iPhone5s.size.width*fullScreen.width;
        size.height = flowlayout.itemSize.width/iPhone5s.size.width*fullScreen.width;

    }
    return size;
    
}

#pragma mark 根据frame 返回frame
+ (CGRect)MyAutoLayoutWithFrame:(CGRect)frame
{
    CGRect rect;
    if (fullScreen.height == 568) {
        rect.size.height = frame.size.height;
        rect.origin.y = frame.origin.y;
    }else{
       rect.size.height = frame.size.height/iPhone5s.size.height*fullScreen.height;
        rect.origin.y = frame.origin.y/iPhone5s.size.height*fullScreen.height;
    }
    rect.size.width = frame.size.width/iPhone5s.size.width*fullScreen.width;
    rect.origin.x = frame.origin.x/iPhone5s.size.width*fullScreen.width;
    
    return rect;
}



+ (CGSize)SherryAutoLayoutWithSize: (CGSize)kid
{
    CGSize rect;
    if (fullScreen.height == 568) {
        rect.height = kid.height;
    }else{
        rect.height = kid.height/iPhone5s.size.height*fullScreen.height;
//        rect.origin.y = frame.origin.y/iPhone5s.size.height*fullScreen.height;
    }
    rect.width = kid.width/iPhone5s.size.width*fullScreen.width;
//    rect.origin.x = frame.origin.x/iPhone5s.size.width*fullScreen.width;
    
    return rect;
}


#pragma mark 根据View去掉高度变化返回frame一般是文字label使用
+ (CGRect)MyAutoLayoutOnlyWidth:(UIView *)aView
{
    CGRect rect = aView.frame;
    rect.size.width = aView.frame.size.width/iPhone5s.size.width*fullScreen.width;
    rect.origin.x = aView.frame.origin.x/iPhone5s.size.width*fullScreen.width;
    if (fullScreen.height == 568) {
        rect.origin.y = aView.frame.origin.y;
    }else{
        rect.origin.y = aView.frame.origin.y/iPhone5s.size.height*fullScreen.height;
    }
    return rect;
}
//sherry 增补试图
+ (CGRect)SherryAutoLayoutOnlyWidth:(UIView *)aView
{
    CGRect rect = aView.frame;
    rect.size.width = aView.frame.size.width/iPhone5s.size.width*fullScreen.width;
    rect.origin.x = aView.frame.origin.x/iPhone5s.size.width*fullScreen.width;
    if (fullScreen.height == 568) {
        rect.origin.y = aView.frame.origin.y;
    }else{
        rect.origin.y = aView.frame.origin.y;
        ///iPhone5s.size.height*fullScreen.height;
    }
    return rect;
}


#pragma mark 返回高度的变化
+ (CGFloat)autoLayoutBackHeight:(CGFloat)height
{
    if (fullScreen.height == 568) {
        return height;
    }else{
        return height/iPhone5s.size.height*fullScreen.height;
    }
}
#pragma mark 返回宽度的变化
+ (CGFloat)autoLayoutBackWidht:(CGFloat)widht
{
    return widht/iPhone5s.size.width*fullScreen.width;
}
#pragma mark 字体高度自适应
+ (CGRect)MyAutoLayout:(UIView *)aView text:(NSString *)text tag:(CGFloat)tag fontOfSize:(CGFloat)fontSize
{
    CGRect frame = [ToolViewAndData MyAutoLayoutOnlyWidth:aView];
    
    return CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, [self heightForText:text ViewWight:frame.size.width isHeightTag:tag fontOfSize:fontSize]);
}


+ (CGFloat)heightForText:(NSString *)text ViewWight:(CGFloat)wight isHeightTag:(CGFloat)tag fontOfSize:(CGFloat)fontSize
{
    // 把文字大小装进字典中
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake(wight, 2000);

    CGRect frame = [text boundingRectWithSize:size
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:dict
                                      context:nil];
    if (tag != 0) {
        if (frame.size.height > tag) {
            return tag;
        }
    }
    return frame.size.height;
}
+ (CGFloat)widthForText:(NSString *)text ViewWight:(CGFloat)wight Viewheight:(CGFloat)height isWidthTag:(CGFloat)tag fontOfSize:(CGFloat)fontSize
{
    // 把文字大小装进字典中
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake(wight, height);
    
    CGRect frame = [text boundingRectWithSize:size
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:dict
                                      context:nil];
    if (tag != 0) {
        if (frame.size.width > tag) {
            return tag;
        }
    }
    return frame.size.width;
}

+ (void)createModelWithDictionary:(NSDictionary *)dict
{
    for ( NSString * key in dict) {
        printf("@property (nonatomic,copy  ) NSString * %s;\n", [key UTF8String]);
    }

}

+ (void)createModelWithObject:(NSDictionary *)dict
{
    [[[ToolViewAndData alloc]init] createModelWithDict:dict];
}

- (void)createModelWithDict:(NSDictionary *)dict
{
    
    for (id object in dict) {
        if ([object isKindOfClass:[NSArray class]]) {
            [self createModelWithArray:object];
        }else if([object isKindOfClass:[NSDictionary class]]){
            [self createModelWithDict:object];
        }else{
            NSString *str = [NSString stringWithFormat:@"%s",[object UTF8String]];
            [self printString:str];
        }
    }
}

- (void)createModelWithArray:(NSArray *)array
{
    
    for (id object  in array) {
        if ([object isKindOfClass:[NSArray class]]) {
            [self createModelWithArray:object];
        }else if([object isKindOfClass:[NSDictionary class]]){
            [self createModelWithDict:object];
        }else{
            NSString *str = [NSString stringWithFormat:@"%s",[object UTF8String]];
            [self printString:str];
        }
    }

}

-(void)printString:(NSString *)str{
     printf("@property (nonatomic,copy  ) NSString * %s;\n",[str UTF8String]);
}

+ (NSString *)createRandom:(NSInteger)num
{
    NSString *strRandom = @"";
    
    for(int i=0; i<num; i++)
    {
        strRandom = [strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
    }
    return strRandom;
}

+(NSString *)bytesToHexString:(Byte[])src dataLen:(int)len
{
    
    NSString *hexStr=@"";
    
    for(int i=0;i<len;i++) {
        
        NSString *newHexStr = [NSString stringWithFormat:@"%x",src[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    return hexStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- XY新增加
/**iphone 6*/
+ (CGRect)MyAutoLayoutIP6:(UIView *)aView
{
    CGRect rect = aView.frame;
    rect.origin.x = aView.frame.origin.x/iPhone6.size.width*fullScreen.width;
    rect.origin.y = aView.frame.origin.y/iPhone6.size.height*fullScreen.height;
    rect.size.width = aView.frame.size.width/iPhone6.size.width*fullScreen.width;
    rect.size.height = aView.frame.size.height/iPhone6.size.height*fullScreen.height;
    return rect;
}

/**iphone 6 根据Frame */
+ (CGRect)MyAutoLayoutWithFrameIP6:(CGRect)frame{
    CGRect rect;
    
    rect.origin.x = frame.origin.x/iPhone6.size.width*fullScreen.width;
    rect.origin.y = frame.origin.y/iPhone6.size.height*fullScreen.height;
    rect.size.width = frame.size.width/iPhone6.size.width*fullScreen.width;
    rect.size.height = frame.size.height/iPhone6.size.height*fullScreen.height;
    
    return rect;
}

/**iphone 6p*/
+ (CGRect)MyAutoLayoutIP6p:(UIView *)aView
{
    CGRect rect = aView.frame;
    rect.origin.x = aView.frame.origin.x/iPhone6Plus.size.width*fullScreen.width;
    rect.origin.y = aView.frame.origin.y/iPhone6Plus.size.height*fullScreen.height;
    rect.size.width = aView.frame.size.width/iPhone6Plus.size.width*fullScreen.width;
    rect.size.height = aView.frame.size.height/iPhone6Plus.size.height*fullScreen.height;
    return rect;
    
}
/**iphone 6p 根据Frame */
+ (CGRect)MyAutoLayoutWithFrameIP6p:(CGRect)frame
{
    CGRect rect;
    rect.origin.x = frame.origin.x/iPhone6Plus.size.width*fullScreen.width;
    rect.origin.y = frame.origin.y/iPhone6Plus.size.height*fullScreen.height;
    rect.size.width = frame.size.width/iPhone6Plus.size.width*fullScreen.width;
    rect.size.height = frame.size.height/iPhone6Plus.size.height*fullScreen.height;
    return rect;
}

//手机格式判断
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
