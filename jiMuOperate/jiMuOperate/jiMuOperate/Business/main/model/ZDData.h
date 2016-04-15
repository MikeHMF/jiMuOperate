//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
extern NSString *const ZDDESKEY;
extern NSString *const ZDDESPHONE;
extern NSString *const ZDDESPWD;
extern NSString *const ZDISREMEMBER;
@interface ZDData : NSObject
/**判断是否有中文*/
+(BOOL)IsChinese:(NSString *)str;
/**中文转译*/
+(NSString*)encodeString:(NSString*)unencodedString;
/**转译成中文*/
+(NSString *)decodeString:(NSString*)encodedString;

+(NSDictionary *)dictWithgrantType;
+(NSDictionary *)dictWithPhone:(NSString *)phone Password:(NSString *)password;

+(NSDictionary *)dictWithOldPassword:(NSString *)oldPassword NewPassword:(NSString *)newPassword ConfirmPassword:(NSString *)confirmPassword;

+(NSDictionary *)dictWithPhone:(NSString *)Phone SMSCode:(NSString *)code Password:(NSString *)password ConfirmPassword:(NSString *)confirmPassword;

+ (NSString *)stringWithDict:(NSDictionary *)dict;
+ (NSString *)stringWithArray:(NSArray *)array;
/**obj 转 NSString(json)*/
+ (NSString *)jsonStringWithObject:(id)obj;


+ (NSDictionary *)dictAndTestData:(NSData *)data;
/**
 *  对字符串进行截取
 */
+ (NSString *)cutoffLoc:(NSString *)returnSoapXML;

+(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt withDESKEY:(NSString *)deskey;
@end
