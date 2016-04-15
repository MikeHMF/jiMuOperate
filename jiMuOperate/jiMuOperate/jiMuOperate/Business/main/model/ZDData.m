//
//  JMMembersViewController.h
//  jiMuOperate
//
//  Created by 胡梅方 on 16/4/14.
//  Copyright © 2016年 jinXinFengLi. All rights reserved.
//

#import "ZDData.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

NSString *const ZDDESKEY = @"djkddjkddjkdlsdjkdlscicilscidjkdlscilsci";
NSString *const ZDDESPHONE = @"ZDDesPhone";
NSString *const ZDDESPWD = @"ZDDesPwd";
NSString *const ZDISREMEMBER = @"isRemember";
@implementation ZDData


+(NSDictionary *)dictWithPhone:(NSString *)phone Password:(NSString *)password{;
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:@"password" forKey:@"grant_type"];
    [dictM setObject:password forKey:@"password"];
    [dictM setObject:phone forKey:@"username"];
    
    return dictM;
}

+(NSDictionary *)dictWithgrantType{
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:@"client_credentials" forKey:@"grant_type"];

    return dictM;
}

+(NSDictionary *)dictWithOldPassword:(NSString *)oldPassword NewPassword:(NSString *)newPassword ConfirmPassword:(NSString *)confirmPassword{
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:oldPassword forKey:@"OldPassword"];
    [dictM setObject:newPassword forKey:@"NewPassword"];
    [dictM setObject:confirmPassword forKey:@"ConfirmPassword"];
    
    return dictM;
}

+(NSDictionary *)dictWithPhone:(NSString *)Phone SMSCode:(NSString *)code Password:(NSString *)password ConfirmPassword:(NSString *)confirmPassword
{
     NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:Phone forKey:@"Phone"];
    [dictM setObject:code forKey:@"SMSCode"];
    [dictM setObject:password forKey:@"Password"];
    [dictM setObject:confirmPassword forKey:@"ConfirmPassword"];
    
    return dictM;

}

+ (NSString *)stringWithDict:(NSDictionary *)dict
{
    NSMutableString *strM = [[NSMutableString alloc]init];
    for (NSString *key in dict.allKeys) {
        NSString *value = [dict objectForKey:key];
        if ([ZDData IsChinese:value]) {
            value = [ZDData encodeString:value];
        }
        
        [strM appendFormat:@"%@=%@",key,value];
        if (![key isEqualToString:dict.allKeys.lastObject]) {
            [strM appendString:@"&"];
        }
    }
    return strM;
}

+(BOOL)IsChinese:(NSString *)str {
    if ([str isKindOfClass:[NSString class]]) {
        for(int i=0; i< [str length];i++){
            int a = [str characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
            {
                return YES;
            }
        }

    }
    return NO;
}

+ (NSString *)stringWithArray:(NSArray *)array
{
    NSMutableString *strM = [[NSMutableString alloc]init];
    [strM appendString:@"["];
    for (NSString *value in array) {
        
        [strM appendFormat:@"%@",value];
        if (array.count >= 1) {
            if (![value isEqualToString:array.lastObject]) {
                [strM appendString:@","];
            }
        }
    }
    
    [strM appendString:@"]"];
    return strM;
}

//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

//URLDEcode
+(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
+ (NSDictionary *)dictAndTestData:(NSData *)data{
    NSDictionary *dictR = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *strR = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"strR === %@,dictR === %@",strR,dictR);

    return dictR;

}

/**
 *  对字符串进行截取
 */
+ (NSString *)cutoffLoc:(NSString *)returnSoapXML
{
    if (returnSoapXML == nil) {
        return nil;
    }
    NSRange range1 = [returnSoapXML rangeOfString:@"<"];
    if(range1.length == 0) return nil;
    NSRange range2 = [returnSoapXML rangeOfString:@">"];
    NSUInteger loc = range1.location + range1.length;
    NSUInteger len = range2.location - loc;
    NSRange rangeM = NSMakeRange(loc, len);
    NSString *returnStr;
    if (range1.length) {
        returnStr = [returnSoapXML substringWithRange:rangeM];
    }
    
    return returnStr;

}

/**obj 转 NSString(json)*/
+ (NSString *)jsonStringWithObject:(id)obj;
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str1 = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [NSMutableString stringWithString:str1];
    //删除空格
    NSRange substr1 = [string rangeOfString:@"\\u0000"];
    while (substr1.location != NSNotFound) {
        [string replaceCharactersInRange:substr1 withString:@""];
        substr1 = [string rangeOfString:@"\\u0000"];
    }

    return string;
}


#pragma mark -- 3des加密和解密
+(NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt withDESKEY:(NSString *)deskey
{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)//解密
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else //加密
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    const void *vkey = (const void *)[deskey UTF8String];
    // NSString *initVec = @"init Vec";
    //const void *vinitVec = (const void *) [initVec UTF8String];
    //  Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) YTNSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                               length:(NSUInteger)movedBytes]
                                       encoding:NSUTF8StringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
}


@end
