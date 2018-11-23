//
//  financeModel.h
//  jiMuOperate
//
//  Created by macbook pro on 2018/11/23.
//  Copyright © 2018年 jinXinFengLi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface financeModel : NSObject
@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *action;
@property(nonatomic, copy) NSString *from;
@property(nonatomic, copy) NSString *to;
@property(nonatomic, copy) NSString *memo;
@property(nonatomic, copy) NSString *quantity;

- (NSDictionary *)parameters;
@end

NS_ASSUME_NONNULL_END
