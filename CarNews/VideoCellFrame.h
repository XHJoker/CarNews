//
//  VideoCellFrame.h
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#import "VideoModel.h"

@interface VideoCellFrame : NSObject

@property (nonatomic,strong) VideoModel *model;

@property (nonatomic, assign) double cellHeight;

@property (nonatomic, assign) CGRect titleLableF;
@property (nonatomic, assign) CGRect imageViewF;
@property (nonatomic, assign) CGRect videoDescriptionLabF;
@property (nonatomic, assign) CGRect timeLabF;

@end
