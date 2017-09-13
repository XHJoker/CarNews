//
//  CNBaseImageView.m
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNBaseImageView.h"

#import <UIImageView+WebCache.h>
#import <UIImageView+YYWebImage.h>

@implementation CNBaseImageView

-(void)setImageWithUrl:(NSString *)aUrl{
    [self setImageWithUrl:aUrl placeHolder:nil];
}

-(void)setImageWithUrl:(NSString *)aUrl placeHolder:(UIImage *)image{
    [self setImageWithUrl:aUrl placeHolder:image finishHandle:nil];
}

-(void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void (^)(BOOL, UIImage *))finishHandle{
    [self setImageWithUrl:url placeHolder:image progressHandle:nil finishHandle:finishHandle];
}

-(void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void (^)(CGFloat))progressHandle finishHandle:(void (^)(BOOL, UIImage *))finishHandle{
    
    [self yy_setImageWithURL:[NSURL URLWithString:url] placeholder:image options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressHandle) {
            progressHandle(receivedSize * 1.0 / expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (finishHandle) {
            finishHandle(error == nil, image);
        }
    }];
}

@end
