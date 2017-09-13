//
//  PictureCellFrame.h
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"
#import <UIKit/UIKit.h>

@interface PictureCellFrame : NSObject

@property (nonatomic, assign) double cellHeight;
@property (nonatomic, strong) ImageModel *imageModel;
@property (nonatomic, assign) CGRect textLableF;
@property (nonatomic, assign) CGRect imageViewF;

@end
