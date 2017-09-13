//
//  CNPictureRequest.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNPictureRequest.h"
#import <MJExtension.h>
#import "PictureModel.h"

@implementation CNPictureRequest
static CNPictureRequest *manager = nil;

+(instancetype)cn_Request{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CNPictureRequest alloc] init];
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
            
            PictureModel *picture = [[PictureModel alloc] init];
            picture.max_time = time;
            picture.has_more = more;
            
            NSArray *dataArray = [dataDic objectForKey:@"data"];
            for (NSDictionary *dic in dataArray) {
                if ([[dic allKeys] containsObject:@"group"]) {
                    
                    ImageModel *image = [[ImageModel alloc] init];
                    NSDictionary *groupDic = [dic objectForKey:@"group"];
                    NSString *content = [groupDic objectForKey:@"content"];
                    NSDictionary *imageDic = [groupDic objectForKey:@"large_image"];
                    NSInteger type = [[groupDic objectForKey:@"media_type"] integerValue];
                    NSArray *imageUrls = [imageDic objectForKey:@"url_list"];
                    NSDictionary *picDic = imageUrls.firstObject;
                    NSString *urls = [picDic objectForKey:@"url"];
                    image.text = content;
                    image.type = type;
                    image.r_width = [[imageDic objectForKey:@"r_width"] floatValue];
                    image.r_height = [[imageDic objectForKey:@"r_height"] floatValue];
                    image.url_list = @[urls];
                    
                    [mutableArray addObject:image];
                }
            }
            
            picture.data = mutableArray;
            
            completion(picture,[message isEqualToString:@"success"] ,error);
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
        
        PictureModel *picture = [[PictureModel alloc] init];
        picture.max_time = time;
        picture.has_more = more;
        
        NSArray *dataArray = [dataDic objectForKey:@"data"];
        for (NSDictionary *dic in dataArray) {
            if ([[dic allKeys] containsObject:@"group"]) {
                
                ImageModel *image = [[ImageModel alloc] init];
                NSDictionary *groupDic = [dic objectForKey:@"group"];
                NSString *content = [groupDic objectForKey:@"content"];
                NSDictionary *imageDic = [groupDic objectForKey:@"large_image"];
                NSInteger type = [[groupDic objectForKey:@"media_type"] integerValue];
                NSArray *imageUrls = [imageDic objectForKey:@"url_list"];
                NSDictionary *picDic = imageUrls.firstObject;
                NSString *urls = [picDic objectForKey:@"url"];
                image.text = content;
                image.type = type;
                image.r_width = [[imageDic objectForKey:@"r_width"] floatValue];
                image.r_height = [[imageDic objectForKey:@"r_height"] floatValue];
                image.url_list = @[urls];
                
                [mutableArray addObject:image];
            }
        }
        
        picture.data = mutableArray;
        
        completion(picture,[message isEqualToString:@"success"] ,error);
    }];
}
@end
