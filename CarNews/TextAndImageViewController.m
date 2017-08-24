//
//  TextAndImageViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "TextAndImageViewController.h"

@interface TextAndImageViewController ()
@property (nonatomic,strong) UISegmentedControl *segment;
@end

@implementation TextAndImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.segment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentChange:(UISegmentedControl *)segment{
    NSLog(@"%d",segment.selectedSegmentIndex);
}

-(UISegmentedControl *)segment{
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"段子",@"图片"]];
        _segment.frame = CGRectMake(0, 0, 150, 30);
        _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        _segment.tintColor = [UIColor whiteColor];
    }
    return _segment;
}

@end
