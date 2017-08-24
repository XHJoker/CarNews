//
//  ImageContentView.m
//  新型轮播图
//
//  Created by zhao on 16/3/21.
//  Copyright © 2016年 xincheng. All rights reserved.
//

#import "ImageContentView.h"
#import <UIButton+WebCache.h>


@interface ImageContentView ()

@property(nonatomic,retain)UIButton *btn;
@property(nonatomic,copy)BtnBlock btnBlock;
@end


@implementation ImageContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithContentFrame:(CGRect)frame andimgUrlStr:(NSString *)imgStr andBtnBlock:(BtnBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds= YES;
        self.btnBlock = block;
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.btn sd_setImageWithURL:[NSURL URLWithString:imgStr] forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        
    }
    return self;
}


-(instancetype)initWithContentFrame:(CGRect)frame andimgStr:(NSString *)imgStr  andBtnBlock:(BtnBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds= YES;
        self.btnBlock = block;
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.btn.layer.contents = (id)[UIImage imageNamed:imgStr].CGImage;
        [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];

    }
    return self;
}

-(void)btnClick:(UIButton *)sender
{
    self.btnBlock();
}


- (void)imageOffsetValue:(float)value {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    
    CGFloat centerX = CGRectGetMidX(centerToWindow);
    CGPoint windowCenter = self.window.center;
    CGFloat cellOffsetX = centerX - windowCenter.x;
    CGAffineTransform transX = CGAffineTransformMakeTranslation(- cellOffsetX * value, 0);

    self.btn.transform = transX;
    

    
    
}



@end
