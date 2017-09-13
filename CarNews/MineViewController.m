//
//  MineViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "MineViewController.h"
#import <YYWebImage.h>
#import "EdtMacro.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self clear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clear{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    
    // 获取缓存大小
    
    NSLog(@"memoryCost:%ld  - memoryCount:%ld   - diskcost:%ld  - diskcount:%ld ",cache.memoryCache.totalCost,cache.memoryCache.totalCount,cache.diskCache.totalCost,cache.diskCache.totalCount);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    lab.font = kFont(15);
    lab.numberOfLines = 0;
    [self.view addSubview:lab];
    
    float memoryCache = cache.memoryCache.totalCost/(1024.0*1024.0) + cache.diskCache.totalCost/(1024.0*1024.0);
    lab.text = [NSString stringWithFormat:@"%.2f",memoryCache];
    
    
    // 清空缓存
    //[cache.memoryCache removeAllObjects];
    //[cache.diskCache removeAllObjects];
    
    // 清空磁盘缓存，带进度回调
    
    /*
    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        // progress
    } endBlock:^(BOOL error) {
        // end
    }];
    */
}

@end
