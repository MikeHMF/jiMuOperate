//
//  JMMembersViewController.m
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import "ViewController.h"
#import "Request.h"
#import "ZDData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [self strategyList];
    /**
     *  能改动否
     */
}

-(void)strategyList
{

   
    NSString *url = [NSString stringWithFormat:@"%@",@"api/Default/GetTypeList"];
    NSArray *aryR = @[@"",url,@"GET"];
    NSLog(@"%@",aryR);
    [Request startRequestWithArray:aryR FinishedBlock:^(NSData *data) {
        NSDictionary *dict = [ZDData dictAndTestData:data];
        NSLog(@"%@",dict);

        
    
    } FailBlock:^(NSString *string) {
        
    }];
}
@end
