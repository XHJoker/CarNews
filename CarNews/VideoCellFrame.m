//
//  VideoCellFrame.m
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "VideoCellFrame.h"

#import "NHUtils.h"
#import "EdtMacro.h"
#import "NSAttributedString+Size.h"

@implementation VideoCellFrame

-(void)setModel:(VideoModel *)model{
    
    if (!model) {
        return;
    }
    
    _model = model;
    
    CGFloat titleLabW = kScreenWidth-20;
    NSAttributedString *string = [NHUtils attStringWithString:model.title keyWord:nil];
    CGFloat contentH  = [string heightWithConstrainedWidth:titleLabW];
    
    CGFloat titleLabH = contentH;
    if (model.title.length == 0) {
        titleLabH= 1.0f;
    }
    self.titleLableF = CGRectMake(10, 5, titleLabW, titleLabH);

    CGFloat imageW = CGRectGetWidth(self.titleLableF);
    CGFloat imageH = kScreenWidth/375.0*200;
    self.imageViewF = CGRectMake(10, CGRectGetMaxY(self.titleLableF), imageW, imageH);
    
    CGFloat timeLabW = 80;
    CGFloat timeLabH = 30;
    CGFloat timeLabX = CGRectGetMaxX(self.imageViewF) - timeLabW -10;
    CGFloat timeLabY = CGRectGetMaxY(self.imageViewF) - titleLabH;
    self.timeLabF = CGRectMake(timeLabX, timeLabY, timeLabW, timeLabH);
    
    NSAttributedString *desString = [NHUtils attStringWithString:model.videoDescription keyWord:nil];
    CGFloat descriptLabH = [desString heightWithConstrainedWidth:titleLabW];
    
    if (model.videoDescription.length == 0) {
        descriptLabH = 1.0f;
    }
    
    CGFloat descriptLabW = titleLabW;
    CGFloat descriptLabX = 10;
    CGFloat descriptLabY = CGRectGetMaxY(self.imageViewF);
    self.videoDescriptionLabF = CGRectMake(descriptLabX, descriptLabY, descriptLabW, descriptLabH);
    
    self.cellHeight = contentH + imageH + descriptLabH + 20;
}

@end
