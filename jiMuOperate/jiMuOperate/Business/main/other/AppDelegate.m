//
//  JMMembersViewController.m
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "JMPinealViewController.h"
#import "JMStrategyViewController.h"
#import "JMFinanceViewController.h"
#import "JMMyViewController.h"
#import "JMMoreViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    ViewController *viewC = [[ViewController alloc]init];
    viewC.view.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:viewC];
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    JMPinealViewController *pineal = [[JMPinealViewController alloc] init];
    UINavigationController *pinealNavigation = [[UINavigationController alloc] initWithRootViewController:pineal];

    
    JMStrategyViewController *strategy = [[JMStrategyViewController alloc] init];
    UINavigationController *strategyNavigation = [[UINavigationController alloc] initWithRootViewController:strategy];
    
    JMFinanceViewController *finance = [[JMFinanceViewController alloc]init];
    UINavigationController *financeNavigation = [[UINavigationController alloc]initWithRootViewController:finance];
 
    
    tabBarController.viewControllers = [NSArray arrayWithObjects:pinealNavigation,strategyNavigation,financeNavigation,nil];
    
    
    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
