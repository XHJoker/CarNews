//
//  PictureViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "PictureViewController.h"
#import "CNPictureRequest.h"
#import "PictureModel.h"
#import <MJRefresh.h>
#import "PictureCell.h"
#import "PictureCellFrame.h"
#import <Masonry.h>
#import "EdtMacro.h"

@interface PictureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *pictureTableView;
@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic,copy) NSString *lastTime;

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMJRefresh];
    [self.pictureTableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMJRefresh{
    
    self.pictureTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.pictureTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.cellFrames.count) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picCell"];
    
    if (!cell) {
        cell = [[PictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picCell"];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins= UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    PictureCellFrame *frame = self.cellFrames[indexPath.row];
    
    [cell setCellFrame:frame];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PictureCellFrame *frame = self.cellFrames[indexPath.row];
    return frame.cellHeight;
}

#pragma mark - Refresh

-(void)refreshData{
    
    CNPictureRequest *request = [CNPictureRequest cn_Request];
    request.baseUrl = @"http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-103";
    [request cn_TextRefreshDataCompletion:^(PictureModel *model, BOOL success, NSError *error) {
        if (success) {
            self.lastTime = model.max_time;
            
            [self.cellFrames removeAllObjects];
            for (ImageModel *imageModel in model.data) {
                PictureCellFrame *frame = [[PictureCellFrame alloc] init];
                frame.imageModel = imageModel;
                [self.cellFrames addObject:frame];
            }
            
            [self.pictureTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)loadMoreData{
    
    CNPictureRequest *request = [CNPictureRequest cn_Request];
    request.baseUrl = @"http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-103";
    [request cn_TextLoadMoreDataWithLastTimeString:self.lastTime Completion:^(PictureModel *model, BOOL success, NSError *error) {
        
        if (success) {
            
            self.lastTime = model.max_time;
            
            for (ImageModel *imageModel in model.data) {
                PictureCellFrame *frame = [[PictureCellFrame alloc] init];
                frame.imageModel = imageModel;
                [self.cellFrames addObject:frame];
            }
            
            [self.pictureTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)endRefreshing{
    
    if ([self.pictureTableView.mj_header isRefreshing]) {
        [self.pictureTableView.mj_header endRefreshing];
    }
    
    if ([self.pictureTableView.mj_footer isRefreshing]) {
        [self.pictureTableView.mj_footer endRefreshing];
    }
}

#pragma mark - getter


-(NSMutableArray *)cellFrames{
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

-(UITableView *)pictureTableView{
    
    if (!_pictureTableView) {
        _pictureTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _pictureTableView.dataSource = self;
        _pictureTableView.delegate = self;
        CGRect rect = self.view.bounds;
        _pictureTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, kScreenHeight-64-49);
        [self.view addSubview:_pictureTableView];
        /*
        [_pictureTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
         */
    }
    
    return _pictureTableView;
}

@end
