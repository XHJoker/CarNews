//
//  CNHomeRequest.h
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"


@interface CNHomeRequest : BaseRequest
@property (nonatomic, strong) NSString *baseUrl;

+(instancetype)cn_Request;

//HomeRefresh
-(void)cn_HomeRefreshDataCompletion:(BaseComplectionBlock)completion;

//HomeLoadMore
-(void)cn_HomeLoadMoreDataCompletion:(BaseComplectionBlock)completion;
@end
