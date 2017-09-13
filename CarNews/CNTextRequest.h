//
//  CNTextRequest.h
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "BaseRequest.h"

@interface CNTextRequest : BaseRequest

@property (nonatomic, strong) NSString *baseUrl;

+(instancetype)cn_Request;
//HomeRefresh
-(void)cn_TextRefreshDataCompletion:(BaseComplectionBlock)completion;

//HomeLoadMore
-(void)cn_TextLoadMoreDataWithLastTimeString:(NSString*)time Completion:(BaseComplectionBlock)completion;

@end
