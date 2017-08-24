//
//  EdtMacro.h
//  EdtDemo
//
//  Created by SiYugui on 2017/1/9.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#ifndef EdtMacro_h
#define EdtMacro_h

#include <stdio.h>

#pragma makr -颜色
#define EDTRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#pragma mark -尺寸
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

#define kViewWidth self.view.frame.size.width
#define kViewHeight self.view.frame.size.height

#pragma mark -字体
/*** 加粗 */
#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]

#pragma mark -weak
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define kScaleSize(a) [[UIScreen mainScreen] bounds].size.width/320.0*a

#endif /* EdtMacro_h */

#ifdef DEBUG
#define XHJLog(fmt, ...) NSLog((@"\r\n=====================分割线=======================\n%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define XHJLog(...)
#endif
