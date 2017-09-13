//
//  PictureCellFrame.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "PictureCellFrame.h"
#import "NHUtils.h"
#import "EdtMacro.h"
#import "NSAttributedString+Size.h"

@implementation PictureCellFrame

-(void)setImageModel:(ImageModel *)imageModel{
    if (!imageModel) {
        return;
    }
    
    _imageModel = imageModel;
    
    CGFloat labW = kScreenWidth-20;
    NSAttributedString *string = [NHUtils attStringWithString:imageModel.text keyWord:nil];
    CGFloat contentH  = [string heightWithConstrainedWidth:labW];

    CGFloat labH = contentH;
    
    if (imageModel.text.length == 0) {
        labH = 1.0f;
    }
    
    self.textLableF = CGRectMake(10, 10, labW, labH);
    
    CGFloat imageW = imageModel.r_width;
    CGFloat imageH = imageModel.r_height;
    self.imageViewF = CGRectMake(CGRectGetMinX(_textLableF), CGRectGetMaxY(_textLableF)+10, labW, labW/imageW*imageH);

    self.cellHeight = CGRectGetMaxY(self.imageViewF)+15;
}

@end
