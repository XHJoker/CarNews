//
//  HomeListViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "HomeListViewController.h"

#import "CNHomeRequest.h"
#import "HomeModel.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "CNHomeRequest.h"
#import "HomeListTableViewCell.h"
#import "EdtMacro.h"
#import "CircleScrollView.h"
#import "HomeDetailViewController.h"

@interface HomeListViewController ()<UITableViewDelegate,UITableViewDataSource,CircleScrollDelegate>
@property (nonatomic,strong) UITableView *homeListTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *headerSource;
@property (nonatomic,strong) NSMutableArray *headerImageUrls;
@property (nonatomic,strong) CircleScrollView *scrollView;
@end

static NSString *identifier = @"HomeCell";



@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI{
    [self setMJRefresh];
    [self.homeListTableView.mj_header beginRefreshing];
}


-(void)setMJRefresh{
    
    self.homeListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.homeListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark - Refresh

-(void)refreshData{
    
    CNHomeRequest *request = [CNHomeRequest cn_Request];
    request.baseUrl = self.homeListUrl;
    [request cn_HomeRefreshDataCompletion:^(HomeModel *model, BOOL success, NSError *error) {
        if (success) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:model.result.newslist];
            
            [self.headerSource removeAllObjects];
            [self.headerSource addObjectsFromArray:model.result.focusimg];
            
            [self.headerImageUrls removeAllObjects];
            for (HomeResultFocusimgModel *focusimg in self.headerSource) {
                [self.headerImageUrls addObject:focusimg.imgurl];
            }
            
            [self.homeListTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)loadMoreData{
    
    CNHomeRequest *request = [CNHomeRequest cn_Request];
    request.baseUrl = self.homeListUrl;
    [request cn_HomeLoadMoreDataCompletion:^(HomeModel *model, BOOL success, NSError *error) {
        
        if (success) {

            [self.dataSource addObjectsFromArray:model.result.newslist];
            [self.homeListTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)endRefreshing{
    
    if ([self.homeListTableView.mj_header isRefreshing]) {
        [self.homeListTableView.mj_header endRefreshing];
    }
    
    if ([self.homeListTableView.mj_footer isRefreshing]) {
        [self.homeListTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins= UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    HomeResultNewslistModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headerSource.count == 0) {
        return 0.1f;
    }else{
        return kScreenWidth*375.0/750;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.headerSource.count == 0) {
        return [UIView new];
    }else{
        return self.scrollView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeResultNewslistModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeDetailViewController *detailVc = [[HomeDetailViewController alloc] init];
    detailVc.ID =model.ID;
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - scrollDelegate

-(void)circleScroll:(CircleScrollView *)scrollView selectIndex:(NSInteger)index{
    HomeDetailViewController *detailVc = [[HomeDetailViewController alloc] init];
    HomeResultFocusimgModel *focusimgModel = self.headerSource[index];
    detailVc.ID =focusimgModel.ID;
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma getter
-(UITableView *)homeListTableView{
    
    if (!_homeListTableView) {
        _homeListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _homeListTableView.dataSource = self;
        _homeListTableView.delegate = self;
        [self.view addSubview:_homeListTableView];
        [_homeListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    
    return _homeListTableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray *)headerSource{
    if (!_headerSource) {
        _headerSource = [NSMutableArray array];
    }
    return _headerSource;
}

-(NSMutableArray *)headerImageUrls{
    if (!_headerImageUrls) {
        _headerImageUrls = [NSMutableArray array];
    }
    return _headerImageUrls;
}

-(CircleScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[CircleScrollView alloc]initWithImgUrls:self.headerImageUrls fram:CGRectMake(0, 0, kScreenWidth, kScreenWidth*375.0/750)];
        _scrollView.circleScrollType = CircleScrollTypePageControlAndTimer;
        //_scrollView.circleScrollStyle = CircleScrollStyleSteadfast;
        _scrollView.circleDelegate = self;
    }
    return _scrollView;
}
@end
