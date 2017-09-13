//
//  ImageModel.h
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "BaseModel.h"

/**
 *  数据类型
 */
typedef NS_ENUM(NSUInteger,MediaType) {
    /** 大图*/
    NHHomeServiceDataElementMediaTypeLargeImage = 1,
    /** Gif图片*/
    NHHomeServiceDataElementMediaTypeGif = 2
};

@interface ImageModel : BaseModel

@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) NSArray *url_list;
@property (nonatomic,assign) MediaType type;
@property (nonatomic,assign) float r_height;
@property (nonatomic,assign) float r_width;

@end
