//
//  HomeModel.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

@end

@implementation HomeResultModel

/** 属性为数组 对应相应的解析类 */
+ (NSDictionary *)objectClassInArray{
    return @{@"newslist" : [HomeResultNewslistModel class], @"focusimg" : [HomeResultFocusimgModel class]};
}

@end

@implementation HomeResultHeadlineinfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end

@implementation HomeResultTopnewsinfoModel

@end

@implementation HomeResultNewslistModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id", @"anewstype":@"newstype"};
}

@end

@implementation HomeResultFocusimgModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
@end
