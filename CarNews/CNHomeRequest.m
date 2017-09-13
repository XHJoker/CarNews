//
//  CNHomeRequest.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNHomeRequest.h"

#import <MJExtension.h>
#import "HomeModel.h"

@implementation CNHomeRequest

static CNHomeRequest *manager = nil;

+(instancetype)cn_Request{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CNHomeRequest alloc] init];
    });
    return manager;
}

#pragma public

-(void)cn_HomeRefreshDataCompletion:(BaseComplectionBlock)completion{
    self.page = 1;
    self.updateTime = @"0";
    
    NSString *url = [NSString stringWithFormat:@"%@-p%ld-s10-l%@.json",self.baseUrl,self.page,self.updateTime];
    
    [self cn_GetRequesWithParams:nil UrlString:url andCompletion:^(id response, BOOL success, NSError *error) {
        if (completion) {
            HomeModel *model = [HomeModel mj_objectWithKeyValues:response];
            self.updateTime = [model.result.newslist lastObject].lasttime;
            completion(model,success ,error);
        }
    }];
}


-(void)cn_HomeLoadMoreDataCompletion:(BaseComplectionBlock)completion{
    self.page += 1;
    NSString *url = [NSString stringWithFormat:@"%@-p%ld-s10-l%@.json",self.baseUrl,self.page,self.updateTime];
    
    [self cn_GetRequesWithParams:nil UrlString:url andCompletion:^(id response, BOOL success, NSError *error) {
        if (completion) {
            HomeModel *model = [HomeModel mj_objectWithKeyValues:response];
            self.updateTime = [model.result.newslist lastObject].lasttime;
            completion(model,success ,error);
        }
    }];
}

@end
