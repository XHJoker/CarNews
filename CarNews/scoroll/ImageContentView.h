//
//  ImageContentView.h
//  新型轮播图
//
//  Created by zhao on 16/3/21.
//  Copyright © 2016年 xincheng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BtnBlock)(void);

@interface ImageContentView : UIView



-(instancetype)initWithContentFrame:(CGRect)frame andimgUrlStr:(NSString *)imgStr andBtnBlock:(BtnBlock)block;

-(instancetype)initWithContentFrame:(CGRect)frame andimgStr:(NSString *)imgStr andBtnBlock:(BtnBlock)block;



- (void)imageOffsetValue:(float)value; //偏移的百分比

@end
