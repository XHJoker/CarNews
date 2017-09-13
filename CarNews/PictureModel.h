//
//  PictureModel.h
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "BaseModel.h"

#import "ImageModel.h"
@class PictureListModel,ImageModel;

@interface PictureModel : BaseModel
@property (nonatomic, assign) BOOL has_more;
@property (nonatomic, copy) NSString *max_time;
@property (nonatomic, strong) NSArray <ImageModel*> *data;

@end


