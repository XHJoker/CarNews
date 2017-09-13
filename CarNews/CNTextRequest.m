//
//  CNTextRequest.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNTextRequest.h"
#import "TextModel.h"
#import <MJExtension.h>
#import "TextModel.h"

@implementation CNTextRequest

static CNTextRequest *manager = nil;
//static NSString *TextUrl = @"http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-102";

 /*
 "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-101",
 "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-104",
 "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-103",
 "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-102",
 "http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-201"
 */

+(instancetype)cn_Request{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CNTextRequest alloc] init];
    });
    return manager;
}

#pragma pri

#pragma mark -初始化参数
- (NSDictionary *)paramsWithTimeString:(NSString *)time {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"tag"] = @"joke";
    params[@"iid"] = @"5316804410";
    params[@"os_version"] = @"9.3.4";
    params[@"os_api"] = @"18";
    
    params[@"app_name"] = @"joke_essay";
    params[@"channel"] = @"App Store";
    params[@"device_platform"] = @"iphone";
    params[@"idfa"] = @"832E262C-31D7-488A-8856-69600FAABE36";
    params[@"live_sdk_version"] = @"120";
    
    params[@"vid"] = @"4A4CBB9E-ADC3-426B-B562-9FC8173FDA52";
    params[@"openudid"] = @"cbb1d9e8770b26c39fac806b79bf263a50da6666";
    params[@"device_type"] = @"iPhone 6 Plus";
    params[@"version_code"] = @"5.5.0";
    params[@"ac"] = @"WIFI";
    params[@"screen_width"] = @"1242";
    params[@"device_id"] = @"10752255605";
    params[@"aid"] = @"7";
    params[@"count"] = @"10";
    params[@"max_time"] = time;
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"nh_delegate"]) {
        [params removeObjectForKey:@"nh_delegate"];
    }
    if ([params.allKeys containsObject:@"nh_isPost"]) {
        [params removeObjectForKey:@"nh_isPost"];
    }
    if ([params.allKeys containsObject:@"nh_url"]) {
        [params removeObjectForKey:@"nh_url"];
    }
    if ([params.allKeys containsObject:@"nh_imageArray"]) {
        [params removeObjectForKey:@"nh_imageArray"];
    }
    return params;
}

/** 刷新*/
-(NSDictionary *)Params{
    
    return [self paramsWithTimeString:[NSString stringWithFormat:@"%.2f",
                                       [[NSDate date] timeIntervalSince1970]]];
    
}

/** 加载更多*/
-(NSDictionary *)getMoreParamsWithMax_time:(NSString *)time{
    
    return [self paramsWithTimeString:time];
}

#pragma public

-(void)cn_TextRefreshDataCompletion:(BaseComplectionBlock)completion{
    
    if (self.baseUrl.length == 0) {
        return;
    }
    
    [self cn_GetRequesWithParams:[self Params] UrlString:self.baseUrl andCompletion:^(id response, BOOL success, NSError *error) {
        if (completion) {
            
            NSMutableArray *mutableArray = [NSMutableArray array];
            
            NSString *message = [response objectForKey:@"message"];
            
            NSDictionary *dataDic = [response objectForKey:@"data"];
            NSString *time = [[dataDic objectForKey:@"max_time"] description];
            BOOL more = [dataDic objectForKey:@"has_more"];
            
            NSArray *dataArray = [dataDic objectForKey:@"data"];
            for (NSDictionary *dic in dataArray) {
                if ([[dic allKeys] containsObject:@"group"]) {
                    NSDictionary *groupDic = [dic objectForKey:@"group"];
                    NSString *text = [groupDic objectForKey:@"text"];
                    [mutableArray addObject:text];
                }
            }
            
            TextModel *model = [[TextModel alloc] init];
            model.has_more = more;
            model.max_time = time;
            model.data = [mutableArray copy];
            
            completion(model,[message isEqualToString:@"success"] ,error);
        }
    }];
}


-(void)cn_TextLoadMoreDataWithLastTimeString:(NSString *)time Completion:(BaseComplectionBlock)completion{
    
    if (self.baseUrl.length == 0) {
        return;
    }
    
    [self cn_GetRequesWithParams:[self paramsWithTimeString:time] UrlString:self.baseUrl andCompletion:^(id response, BOOL success, NSError *error) {
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        NSString *message = [response objectForKey:@"message"];
        
        NSDictionary *dataDic = [response objectForKey:@"data"];
        NSString *time = [[dataDic objectForKey:@"max_time"] description];
        BOOL more = [dataDic objectForKey:@"has_more"];
        
        NSArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            if ([[dic allKeys] containsObject:@"group"]) {
                NSDictionary *groupDic = [dic objectForKey:@"group"];
                NSString *text = [groupDic objectForKey:@"text"];
                [mutableArray addObject:text];
            }
        }
        
        TextModel *model = [[TextModel alloc] init];
        model.has_more = more;
        model.max_time = time;
        model.data = mutableArray;
        
        completion(model,[message isEqualToString:@"success"] ,error);
    }];
}

@end
