//
//  NSAttributedString+Size.h
//  NH
//
//  Created by SiYugui on 16/11/7.
//  Copyright © 2016年 SiYugui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Size)

/**
 *  根据约束的宽度来求NSAttributedString的高度
 */
- (CGFloat)heightWithConstrainedWidth:(CGFloat)width ;


@end
