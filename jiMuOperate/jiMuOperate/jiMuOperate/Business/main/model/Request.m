//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import "Request.h"
#import "CommonFunc.h"
#import "NetInterface.h"
#define strIOS @"iosdfnap445t3516s1df64y3f4et1w:9u5hy98hdafghriy74h68sek439226598reger6gg32sdgtrh3cgsrt"

#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface Request() <NSURLConnectionDataDelegate>
@property(nonatomic,retain)NSMutableData *downloadData;
@end

@implementation Request



+ (void)startRequestWithArray:(NSArray *)arrayStaye FinishedBlock:(DownloadFinishedBlock)finishedBlock FailBlock:(DownloadFailedBlock)faileBlock
{
    [[[Request alloc]init] startTheConnectionWithArray:arrayStaye FinishedBlock:finishedBlock FailBlock:faileBlock];
}

//开始请求
- (void)startTheConnectionWithArray:(NSArray *)arrayStaye FinishedBlock:(DownloadFinishedBlock)finishedBlock FailBlock:(DownloadFailedBlock)faileBlock{
    
    if (self.finishedBlock != finishedBlock) {
        self.finishedBlock = nil;
        self.finishedBlock = finishedBlock;
    }
    if (self.faileBlock != faileBlock) {
        self.faileBlock = nil;
        self.faileBlock = faileBlock;
    }
    
    


    
    
    //请求发送到的路径
    NSString *str = [NSString stringWithFormat:@"%@%@",ZDURLString,arrayStaye[1]];
    
    NSURL *url = [NSURL URLWithString:str];
    NSLog(@"url:%@",url);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *authStr;
//    if (user.access_token.length) {//判断是否请求过token
//        authStr = [NSString stringWithFormat:@"%@ %@",user.token_type,user.access_token];
//        [urlRequest addValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
//    }else{
//        NSString *encodeStr = [CommonFunc base64StringFromText:strIOS];
////        NSLog(@"strIOS====%@,\nencodeStr====%@",strIOS,encodeStr);
//        authStr = [NSString stringWithFormat:@"Basic %@",encodeStr];
//        [urlRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    }
    
    [urlRequest addValue:authStr forHTTPHeaderField:@"Authorization"];
    //关于缓存
    if (![Request isConnectionAvailable]) {
        urlRequest.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    urlRequest.timeoutInterval = 20;
    
    if (arrayStaye.count > 2) {
        if ([arrayStaye[2] isEqualToString:@"GET"]) {
           NSLog(@"GET请求");
            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
            return;
        };
    }
    NSString *msgLength;
    //以下对请求信息添加属性前四句是必有的，
    if ([arrayStaye[0] isKindOfClass:[NSString class]]) {
        NSString *msg = arrayStaye[0];
        //拼接方法
        [urlRequest setHTTPBody:[msg dataUsingEncoding:NSUTF8StringEncoding]];
        
        msgLength = [NSString stringWithFormat:@"%ld", (unsigned long)msg.length];
    }else if([arrayStaye[0] isKindOfClass:[NSData class]]){
        NSData *data = arrayStaye[0];
        [urlRequest setHTTPBody:data];
        msgLength = [NSString stringWithFormat:@"%ld", (unsigned long)data.length];
    }
    
    [urlRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest addValue: @"application/json" forHTTPHeaderField:@"Accept"];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    //请求 类方法自动开始
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}


//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //    SHOWALERT(@"亲，您的网络未连接···");
    NSLog(@"ERROR with theConenction");
    
    if (self.faileBlock) {
        self.faileBlock((NSString *)[NSString stringWithFormat:@"%@",error]);
    }
    
}

//接收到服务器回应的时回调
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    if(_downloadData){
        [_downloadData setLength:0]; //清空以前的数据
    }else{
        _downloadData = [[NSMutableData alloc]init];
    }
}

// 接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)responseData
{
//    ZDLog(@"responseData----%@",responseData);
    [_downloadData appendData:responseData];
    
}

//数据传完之后调用此方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSData *data = self.downloadData;
    if (self.finishedBlock) {
        self.finishedBlock(data);//小心死循环
    }
    
}



+ (BOOL)isConnectionAvailable{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
      return isExistenceNetwork;
}

@end
