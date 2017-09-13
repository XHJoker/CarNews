//
//  CNVideoRequest.h
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "BaseRequest.h"

@interface CNVideoRequest : BaseRequest
@property (nonatomic, strong) NSString *baseUrl;

+(instancetype)cn_Request;

-(void)cn_VideoRefreshDataCompletion:(BaseComplectionBlock)completion;

-(void)cn_VideoLoadMoreDataCompletion:(BaseComplectionBlock)completion;
@end
