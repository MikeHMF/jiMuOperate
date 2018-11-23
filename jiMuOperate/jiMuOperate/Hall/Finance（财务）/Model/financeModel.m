//
//  financeModel.m
//  jiMuOperate
//
//  Created by macbook pro on 2018/11/23.
//  Copyright © 2018年 jinXinFengLi. All rights reserved.
//

#import "financeModel.h"

@implementation financeModel


- (NSDictionary *)parameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: VALIDATE_STRING(self.code) forKey:@"code"];
    [params setObject:VALIDATE_STRING(self.action) forKey:@"action"];
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
    [args setObject:VALIDATE_STRING(self.from) forKey:@"from"];
    [args setObject:VALIDATE_STRING(self.to) forKey:@"to"];
    [args setObject:VALIDATE_STRING(self.memo) forKey:@"memo"];
    [args setObject:VALIDATE_STRING(self.quantity) forKey:@"quantity"];
    [params setObject:args forKey:@"args"];
    return params;
    
    
    
}
@end
