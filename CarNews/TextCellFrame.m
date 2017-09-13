//
//  TextCellFrame.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "TextCellFrame.h"

#import "NHUtils.h"
#import "NSAttributedString+Size.h"
#import "EdtMacro.h"

@implementation TextCellFrame

-(void)setWord:(NSString *)word{
    
    if (word.length == 0) {
        return ;
    }
    _word = word;
    
    CGFloat labW = kScreenWidth-20;
    
    NSAttributedString *string = [NHUtils attStringWithString:word keyWord:nil];
    CGFloat contentH  = [string heightWithConstrainedWidth:labW];
    
    CGFloat labH = contentH;
    self.textLableF = CGRectMake(10, 10, labW, labH);
    self.cellHeight = CGRectGetMaxY(_textLableF)+15;
}


@end
