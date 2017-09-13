//
//  CNVIdeoImageView.h
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNBaseImageView.h"

@interface CNVIdeoImageView : CNBaseImageView
@property (nonatomic, copy) void(^videoTableCellVideoDidBeginPlayHandle)(UIButton *playBtn);

@end
