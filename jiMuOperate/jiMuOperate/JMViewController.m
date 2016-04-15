//
//  JMViewController.m
//  jiMuOperate
//
//  Created by 翁仪 on 16/4/15.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import "JMViewController.h"
#import "FinanceTableView.h"
#import "MoreTableView.h"
#import "MySelfTableView.h"
#import "PineConeTableView.h"
#import "StrategyTableView.h"
#import "JMNavigationController.h"
// 随机色
#define JMRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
@interface JMViewController ()

@end

@implementation JMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
// 添加子控制器
    //    添加松果控制器
        PineConeTableView * PineCone = [[PineConeTableView alloc] init];
        [self addOneChlildVc:PineCone title:@"松果" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];

    //    添加策略控制器
        StrategyTableView *  Strategy = [[StrategyTableView alloc] init];
        [self addOneChlildVc: Strategy title:@"策略" imageName:@"tabbar_compose_icon_add" selectedImageName:@"tabbar_compose_icon_add_highlighted"];

    //    添加财务控制器
        FinanceTableView * Finance = [[FinanceTableView alloc] init];
        [self addOneChlildVc:Finance title:@"财务" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    //    添加我的控制器
        MySelfTableView *  MySelf = [[MySelfTableView alloc] init];
        [self addOneChlildVc: MySelf title:@"我的" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    //    添加更多控制器
        MoreTableView *  More = [[MoreTableView alloc] init];
        [self addOneChlildVc: More title:@"更多" imageName:@"tabbar_more" selectedImageName:@"tabbar_more_selected"];

}
/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
        childVc.view.backgroundColor = JMRandomColor;
    // 设置标题
    
    childVc.title = title;
    
    // 设置图标
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    // 设置选中的图标   
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    childVc.tabBarItem.selectedImage = selectedImage;

    // 添加为tabbar控制器的子控制器
    JMNavigationController *nav = [[JMNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
