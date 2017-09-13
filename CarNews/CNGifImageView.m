//
//  CNGifImageView.m
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNGifImageView.h"
#import <UIKit/UIKit.h>

@interface CNGifImageView ()
@property (nonatomic,weak) CAShapeLayer *shapeLayer;
@end

@implementation CNGifImageView

-(void)setProgress:(CGFloat)progress{
    
    _progress = progress;
    
    if (_progress == 1.0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.2 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [_shapeLayer removeFromSuperlayer];
            _shapeLayer = nil;
            return ;
        });
    }else{
        UIBezierPath *path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width *_progress, 5)];
        self.shapeLayer.path = path.CGPath;
    }
}

-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor orangeColor].CGColor;
        [self.layer addSublayer:layer];
        _shapeLayer = layer;
    }
    return _shapeLayer;
}

@end
