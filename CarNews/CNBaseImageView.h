//
//  CNBaseImageView.h
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import <YYImage/YYImage.h>

@interface CNBaseImageView : YYAnimatedImageView

-(void)setImageWithUrl:(NSString*)aUrl;

-(void)setImageWithUrl:(NSString *)aUrl placeHolder:(UIImage *)image;

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

@end
