//
//  BaseRequest.h
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BaseComplectionBlock)(id response , BOOL success , NSError*error);

@interface BaseRequest : NSObject

@property (strong , nonatomic) NSString *updateTime;
@property (nonatomic , assign) NSInteger page;

-(void)cn_GetRequesWithParams:(NSDictionary *)params UrlString:(NSString*)aUrl andCompletion:(BaseComplectionBlock)completion;
@end
