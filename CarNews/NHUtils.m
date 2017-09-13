//
//  NHUtils.m
//  NH
//
//  Created by SiYugui on 16/11/8.
//  Copyright © 2016年 SiYugui. All rights reserved.
//

#import "NHUtils.h"
#import "EdtMacro.h"

@implementation NHUtils

// 时间戳转时间
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format {
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

// 几天前 几分钟前..
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timeInterval;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {
        
        return [NSString stringWithFormat:@"%ld分钟前", minutes];
    }
    // 秒转小时
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    // 秒转天数
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    // 秒转月
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    // 秒转年
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

// 公共富文本
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord {
    return [self attStringWithString:string keyWord:keyWord font:kFont(16) highlightedColor:[UIColor redColor] textColor:[UIColor blackColor]];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor {
    return [self attStringWithString:string keyWord:keyWord font:font highlightedColor:highlightedcolor textColor:textColor lineSpace:2.0];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace {
    if (string.length) {
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
        if (!keyWord || keyWord.length == 0) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        NSRange range = [string rangeOfString:keyWord options:NSCaseInsensitiveSearch];
        // 找到了关键字
        if (range.location != NSNotFound) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightedcolor range:range];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
        } else {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        return attStr.copy;
    }
    return [[NSAttributedString alloc] init];
}

+ (NSString *)validString:(NSString *)string {
    
    if ([self isBlankString:string]) {
        return  @"";
    } else {
        return string;
    }
}
/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}



@end
