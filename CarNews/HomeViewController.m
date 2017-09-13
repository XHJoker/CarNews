//
//  HomeViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListViewController.h"

@interface HomeViewController ()
@property (nonatomic,strong) NSArray *subTitles;
@property (nonatomic,strong) NSArray *subUrls;
@property (nonatomic,strong) NSArray *subControllers;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = YES;
    self.title = @"资讯";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 初始化代码
- (instancetype)init {
    
    if (self = [super init]) {
        self.subControllers = [self viewControllerClasses];
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 18;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / 5.0;
        
    }
    
    return self;
}

#pragma mark - delegate

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.subTitles.count;
}

-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.subTitles[index];
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    return self.subControllers[index];
}

-(NSArray *)subTitles{
    if (!_subTitles) {
        _subTitles = @[@"最新",@"新闻",@"评测",@"导购",@"用车",@"技术",@"文化",@"改装",@"游记"];
    }
    return _subTitles;
}

-(NSArray *)subUrls{
    if (!_subUrls) {
        _subUrls = @[@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt1",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt3",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt60",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt82",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt102",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt97",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt107",
                     @"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt100"];
    }
    
    return _subUrls;
}

-(NSArray *)subControllers{
    if (!_subControllers) {
        NSMutableArray *mutableArray = [NSMutableArray new];
        for (int i =0; i<self.subTitles.count; i++) {
            HomeListViewController *vc = [[HomeListViewController alloc] init];
            vc.homeListUrl = self.subUrls[i];
            [mutableArray addObject:vc];
        }
        _subControllers = [mutableArray copy];
    }
    
    return _subControllers;
}


@end
