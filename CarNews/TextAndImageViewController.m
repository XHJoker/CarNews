//
//  TextAndImageViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "TextAndImageViewController.h"

#import "TextViewController.h"
#import "PictureViewController.h"

@interface TextAndImageViewController ()
@property (nonatomic ,strong) UISegmentedControl *segment;
@property (nonatomic ,strong) TextViewController *textVC;
@property (nonatomic ,strong) PictureViewController *pictureVC;
@end

@implementation TextAndImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.segment;
    [self segmentDefaultSelect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentDefaultSelect{;
    
    [self segmentChange:self.segment];
}

-(void)segmentChange:(UISegmentedControl *)segment{
    
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            //[self addChildViewController:self.textVC];
            [self.view addSubview:self.textVC.view];
            
            [self.pictureVC.view removeFromSuperview];
            [self.pictureVC willMoveToParentViewController:nil];
            [self.pictureVC removeFromParentViewController];
        }
            break;
        case 1:
        {
            //[self addChildViewController:self.pictureVC];
            [self.view addSubview:self.pictureVC.view];
            
            [self.textVC.view removeFromSuperview];
            [self.textVC willMoveToParentViewController:nil];
            [self.textVC removeFromParentViewController];
        }
            break;
            
        default:
            break;
    }
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

-(TextViewController *)textVC{
    if (!_textVC) {
        TextViewController *text = [[TextViewController alloc] init];
        _textVC =text;
    }
    return _textVC;
}

-(PictureViewController *)pictureVC{
    if (!_pictureVC) {
        PictureViewController *picture = [[PictureViewController alloc] init];
        _pictureVC = picture;
    }
    return _pictureVC;
}

@end
