//
//  VideoCell.h
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoCellFrame.h"
#import "CNVIdeoImageView.h"

@class VideoCell;
@protocol VideoCellPlayDelegate <NSObject>

- (void)videoTableViewCell:(VideoCell *)cell didClickPlayBtnWithVideoUrl:(NSString *)videoUrl videoCover:(CNVIdeoImageView *)videoImageView;

@end

@interface VideoCell : UITableViewCell

-(void)setCellFrame:(VideoCellFrame*)frame;

@property (nonatomic , weak) id<VideoCellPlayDelegate> delegate;

@end

