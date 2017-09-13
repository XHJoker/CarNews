//
//  VideoModel.h
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *videoDescription;

@property (nonatomic, assign) double length;

@property (nonatomic, strong) NSString *coverUrl;

@property (nonatomic, strong) NSString *mp4_url;
@end
