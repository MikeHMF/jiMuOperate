//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#ifndef UnionRich_Screen_header_h
#define UnionRich_Screen_header_h

#define ZDMange 10
#define FONTSIZE 13

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

//Alert
#define ALERT(msg) [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil]
#define ALERTBUTTON(msg,button) [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:button, nil]
#define ALERTTITLE(title,msg) [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil]
#define ALERTTTBUTTON(title,msg,button) [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:button, nil]

#define SHOWALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil] show]
#define SHOWALERTBUTTON(msg,button) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:button, nil] show]
#define SHOWALERTTITLE(title,msg) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil] show]
#define SHOWALERTTTBUTTON(title,msg,button) [[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:button] show]

// 是否隐藏tabbar，navigaction
#define HIDDENNAV(state) self.navigationController.navigationBar.hidden = state
#define HIDDENTAB(state) self.tabBarController.tabBar.hidden = state


//删除tableView多余的线

#define HIDETABVLINE(tableView) UIView *tableFooterView =[ [UIView alloc]init];\
tableFooterView.backgroundColor = [UIColor blackColor];\
[tableView setTableFooterView:tableFooterView];\
tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

//转换时间方法
#define OLDTMIEFormatter @"yyyy-MM-dd HH:mm:ss.SSS"
#define NEWTMIEFormatter @"yyyy/MM/dd HH:mm"

#define CHANGEDATA(dateStr,oldFormatter,newFormatter)\
NSRange range111 = [dateStr rangeOfString:@"T"];\
if (range111.length) {\
dateStr = [dateStr stringByReplacingCharactersInRange:range111 withString:@" "];\
}\
NSDate *date = [[NSDate alloc]init];\
NSDateFormatter * df = [[NSDateFormatter alloc]init];\
df.dateFormat = oldFormatter;\
date = [df dateFromString:dateStr];\
df.dateFormat = newFormatter;\
dateStr = [df stringFromDate:date];

//禁止旋转
#define SHOULDAutorotate(staye)\
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation\
{\
return (toInterfaceOrientation == UIInterfaceOrientationPortrait);\
}\
- (BOOL)shouldAutorotate\
{\
return staye;\
}\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
return UIInterfaceOrientationMaskPortrait;\
}

//设置背景颜色
#define setupBackImage(view)\
UIImageView* imgBG=[ARC createImageViewWithFrame:[UIScreen mainScreen].bounds ImageName:@"blackBackground"];\
imgBG.contentMode = UIViewContentModeScaleToFill;\
[view addSubview: imgBG];\
[view sendSubviewToBack:imgBG];\


//debug状态打印，debugMethod()打印当前函数名
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif
//测试可以用ZDLog
#define ZDLog(...) NSLog(__VA_ARGS__)
//#define ZDLog(...)


//tableView 的颜色
//#define tableVColor RGB(234,234,234)
#define ZDTableVColor [UIColor blackColor]

//系统是否大于等于IOS9
#define IOS9 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=9)

//字符串是否为空
#define IsStrEmpty(_ref)  (((_ref) == nil) ||([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqualToString:@""]))

#define IsIpad (SCREEN_WIDTH >= 768)

#endif


