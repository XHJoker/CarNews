//
//  baseNavigationController.m
//  CarNewsComing
//
//  Created by SiYugui on 2017/8/22.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "baseNavigationController.h"

@interface baseNavigationController ()

@end

@implementation baseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)initialize{
    
    // 设置为不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    // 设置导航栏背景颜色
    [UINavigationBar appearance].barStyle = UIBarStyleBlackOpaque;
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    // 设置导航栏标题文字颜色
    // 创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20.0f];
    color[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:color];
    
    // 拿到整个导航控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor whiteColor];
    // 设置字典的字体大小
    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
    
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:17.0f];
    atts[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 将字典给item
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];

    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBackgroundImage"] forBarMetrics:UIBarMetricsDefault];
}

@end
