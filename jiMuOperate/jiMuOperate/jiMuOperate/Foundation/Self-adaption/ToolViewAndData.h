//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolViewAndDataDeledate <NSObject>

- (void)searchSoundBtnAction:(UIButton *)btn;

@end

@interface ToolViewAndData : UIViewController

@property (nonatomic, retain) UITextField *searchTextField;
@property (nonatomic, retain) UIButton *searchSoundBtn;
@property (nonatomic, assign) id<ToolViewAndDataDeledate> delegate;

+ (ToolViewAndData *)shareToolViewAngData;
// create btn
+ (UIButton *)addBtn:(CGRect)frame title:(NSString *)title backImage:(NSString *)image;
// searchHot Footer view
+ (UIButton *)footer:(CGRect)frame;

// search view search path
- (UIView *)searchPathWithFrame:(CGRect)frame;
/**iphone 5 自适配*/
+ (CGRect)MyAutoLayout:(UIView *)aView;
/**iphone 5 根据Frame */
+ (CGRect)MyAutoLayoutWithFrame:(CGRect)frame;

/**iphone 6*/
+ (CGRect)MyAutoLayoutIP6:(UIView *)aView;
/**iphone 6 根据Frame */
+ (CGRect)MyAutoLayoutWithFrameIP6:(CGRect)frame;

/**iphone 6p*/
+ (CGRect)MyAutoLayoutIP6p:(UIView *)aView;
/**iphone 6p 根据Frame */
+ (CGRect)MyAutoLayoutWithFrameIP6p:(CGRect)frame;


+ (CGSize)SherryAutoLayoutWithSize: (CGSize)kid;

+ (CGRect)MyAutoLayoutOnlyWidth:(UIView *)aView;
//sherry
+ (CGRect)SherryAutoLayoutOnlyWidth:(UIView *)aView;


+ (CGFloat)autoLayoutBackHeight:(CGFloat)height;

+ (CGFloat)autoLayoutBackWidht:(CGFloat)widht;

+ (CGSize)autoLayoutSize: (UICollectionViewFlowLayout *)flowlayout;
// 根据文字返回height
+ (CGFloat)heightForText:(NSString *)text ViewWight:(CGFloat)wight isHeightTag:(CGFloat)tag fontOfSize:(CGFloat)fontSize;
// 根据文字返回控件的rect
+ (CGRect)MyAutoLayout:(UIView *)aView text:(NSString *)text tag:(CGFloat)tag fontOfSize:(CGFloat)fontSize;
// 字体的宽度
+ (CGFloat)widthForText:(NSString *)text ViewWight:(CGFloat)wight Viewheight:(CGFloat)height isWidthTag:(CGFloat)tag fontOfSize:(CGFloat)fontSize;

//btn的封装
+ (UIButton *)btnWithFrame: (CGRect)frane andTitle:(NSString *)title andTitleFont: (CGFloat)fontFloat;

// 创建model
+ (void)createModelWithDictionary:(NSDictionary *)dict;
+ (void)createModelWithObject:(NSDictionary *)dict;

// 生成n位随机数，并转化为字符串
+ (NSString *)createRandom:(NSInteger)num;

+ (NSString *)bytesToHexString:(Byte[])src dataLen:(int)len;
/**
 *  手机格式判断
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
