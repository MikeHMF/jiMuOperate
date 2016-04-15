//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import <Foundation/Foundation.h>
//用block封装网络请求
typedef void(^DownloadFinishedBlock)(NSData *data);
typedef void(^DownloadFailedBlock)(NSString *string);
@interface Request : NSObject


/**开始请求
 ** arrayStaye[2] 请求方法默认为post 或者为大写GET
 ** arrayStaye[1] 请求方法名，即请求的URL（后半段）
 ** arrayStaye[0] 请求参数，即主体
 ** finishedBlock 请求成功返回数据
 ** faileBlock    请求失败返回数据
 */
+ (void)startRequestWithArray:(NSArray *)arrayStaye FinishedBlock:(DownloadFinishedBlock)finishedBlock FailBlock:(DownloadFailedBlock)faileBlock;
//开始请求
- (void)startTheConnectionWithArray:(NSArray *)arrayStaye FinishedBlock:(DownloadFinishedBlock)finishedBlock FailBlock:(DownloadFailedBlock)faileBlock;


/**接收外部传过来的值*/
@property(nonatomic,copy)DownloadFinishedBlock finishedBlock;
/**接收失败了错误信息*/
@property(nonatomic,copy)DownloadFailedBlock faileBlock;

+ (BOOL)isConnectionAvailable;

@end
