//
//  baseTabBarController.m
//  CarNewsComing
//
//  Created by SiYugui on 2017/8/22.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "baseTabBarController.h"
#import "baseNavigationController.h"

#import "HomeViewController.h"
#import "TextAndImageViewController.h"
#import "VideoViewController.h"
#import "MineViewController.h"

@interface baseTabBarController ()

@end

@implementation baseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSubviews{
    
    [self addChildViewControllerWithClassName:[HomeViewController description] imageName:@"news" title:@"汽车"];
    [self addChildViewControllerWithClassName:[TextAndImageViewController description] imageName:@"text" title:@"搞笑"];
    [self addChildViewControllerWithClassName:[VideoViewController description] imageName:@"live" title:@"视频"];
    [self addChildViewControllerWithClassName:[MineViewController description] imageName:@"mine" title:@"我的"];
    
}

#pragma mark - addChildViewController

- (void)addChildViewControllerWithClassName:(NSString *)className
                                  imageName:(NSString *)imgName
                                      title:(NSString *)title
{
    UIViewController *controller = [[NSClassFromString(className) alloc] init];
    baseNavigationController *nav = [[baseNavigationController alloc] initWithRootViewController:controller];
    nav.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imgName];
    //取消选中变色,使用原图
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imgName stringByAppendingString:@"_s"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

@end
