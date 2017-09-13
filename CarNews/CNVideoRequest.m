//
//  CNVideoRequest.m
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNVideoRequest.h"
#import "VideoModel.h"

static CNVideoRequest *manager = nil;

@implementation CNVideoRequest

+(instancetype)cn_Request{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CNVideoRequest alloc] init];
    });
    return manager;
}

#pragma public

-(void)cn_VideoRefreshDataCompletion:(BaseComplectionBlock)completion{
    
    if (self.baseUrl.length == 0) {
        return;
    }
    
    self.page = 0;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html",self.page];
    
    [self cn_GetRequesWithParams:nil UrlString:url andCompletion:^(id response, BOOL success, NSError *error) {
        if (completion) {
            
            NSMutableArray *mutableArray = [NSMutableArray array];
            
            NSArray *videoList = [response objectForKey:@"videoList"];
            
            for (NSDictionary *videoDic in videoList) {
                VideoModel *model = [[VideoModel alloc] init];
                model.title = [videoDic objectForKey:@"title"];
                model.videoDescription = [videoDic objectForKey:@"description"];
                model.length = [[videoDic objectForKey:@"length"] integerValue];
                model.coverUrl = [videoDic objectForKey:@"cover"];
                model.mp4_url = [videoDic objectForKey:@"mp4_url"];
                
                [mutableArray addObject:model];
            }
            
            completion([mutableArray copy],success ,error);
        }
    }];
}


-(void)cn_VideoLoadMoreDataCompletion:(BaseComplectionBlock)completion{
    
    if (self.baseUrl.length == 0) {
        return;
    }
    self.page += 10;
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%ld-10.html",self.page];
    
    [self cn_GetRequesWithParams:nil UrlString:url andCompletion:^(id response, BOOL success, NSError *error) {
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        NSArray *videoList = [response objectForKey:@"videoList"];
        
        for (NSDictionary *videoDic in videoList) {
            VideoModel *model = [[VideoModel alloc] init];
            model.title = [videoDic objectForKey:@"title"];
            model.videoDescription = [videoDic objectForKey:@"description"];
            model.length = [[videoDic objectForKey:@"length"] integerValue];
            model.coverUrl = [videoDic objectForKey:@"cover"];
            model.mp4_url = [videoDic objectForKey:@"mp4_url"];
            
            [mutableArray addObject:model];
        }
        
        completion([mutableArray copy],success ,error);
    }];
}

@end
