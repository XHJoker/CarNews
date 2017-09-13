//
//  BaseRequest.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "BaseRequest.h"
#import "BaseRequestManager.h"

@implementation BaseRequest

-(void)cn_GetRequesWithParams:(NSDictionary *)params UrlString:(NSString *)aUrl andCompletion:(BaseComplectionBlock)completion{
    
    [BaseRequestManager GET:[self noWhiteSpaceString:aUrl] parameters:params responseSeializerType:ResponseSeializerTypeJSON success:^(id responseObject) {
        // 处理数据
        [self handleWithParams:params Response:responseObject completion:completion];
    } failure:^(NSError *error) {
        // 数据请求失败，暂时不做处理
        completion(nil,NO,error);
    }];
}

#pragma mark -构造

- (NSString *)noWhiteSpaceString:(NSString*)string {
    NSString *newString = [string copy];
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    //    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return [newString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark -返回数据处理

- (void)handleWithParams:(NSDictionary *)params Response:(id)responseObject completion:(BaseComplectionBlock)completion {
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        NSError *error;
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            NSLog(@"AFN工具类解析出错:%@",error);
        }
    }
    
    if (completion) {
        completion(responseObject, YES, nil);
    }
}


@end
