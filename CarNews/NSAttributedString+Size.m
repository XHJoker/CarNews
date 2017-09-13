//
//  NSAttributedString+Size.m
//  NH
//
//  Created by SiYugui on 16/11/7.
//  Copyright © 2016年 SiYugui. All rights reserved.
//

#import "NSAttributedString+Size.h"

#import <CoreText/CoreText.h>

@implementation NSAttributedString (Size)

- (CGFloat)boundingHeightForWidth:(CGFloat)inWidth {
    
    
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {
        return 0;
    }
    
    return [self boundingRectWithSize:CGSizeMake(inWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 3;
}


- (CGFloat)boundingWidthForHeight:(CGFloat)inHeight {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef) self);
    CGSize suggestedSize         = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0),NULL, CGSizeMake(CGFLOAT_MAX, inHeight), NULL);
    CFRelease(framesetter);
    return suggestedSize.width;
}


- (CGFloat)heightWithConstrainedWidth:(CGFloat)width {
    
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {
        return 0;
    }
    
    return [self boundingHeightForWidth:width];
}


@end
