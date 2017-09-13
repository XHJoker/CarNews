//
//  TextViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "TextViewController.h"

#import <MJRefresh.h>
#import "CNTextRequest.h"
#import "TextModel.h"
#import <Masonry.h>
#import "TextCellFrame.h"
#import "TextCell.h"
#import "EdtMacro.h"

@interface TextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *textTableView;

@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic,copy) NSString *lastTime;
@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.translucent = YES;
    [self setMJRefresh];
    [self.textTableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMJRefresh{
    
    self.textTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.textTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
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
    TextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
    if (!cell) {
        cell = [[TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textCell"];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins= UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    TextCellFrame *frame = self.cellFrames[indexPath.row];
    
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
    
    TextCellFrame *frame = self.cellFrames[indexPath.row];
    return frame.cellHeight;
}

#pragma mark - Refresh

-(void)refreshData{
    
    CNTextRequest *request = [CNTextRequest cn_Request];
    request.baseUrl = @"http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-102";
    [request cn_TextRefreshDataCompletion:^(TextModel *model, BOOL success, NSError *error) {
        if (success) {
            self.lastTime = model.max_time;
            
            [self.cellFrames removeAllObjects];
            for (NSString*word in model.data) {
                TextCellFrame *frame = [[TextCellFrame alloc] init];
                frame.word = word;
                [self.cellFrames addObject:frame];
            }
            
            [self.textTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)loadMoreData{
    
    CNTextRequest *request = [CNTextRequest cn_Request];
    request.baseUrl = @"http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-102";
    [request cn_TextLoadMoreDataWithLastTimeString:self.lastTime Completion:^(TextModel *model, BOOL success, NSError *error) {
        
        if (success) {
            
            self.lastTime = model.max_time;
            
            for (NSString*word in model.data) {
                TextCellFrame *frame = [[TextCellFrame alloc] init];
                frame.word = word;
                [self.cellFrames addObject:frame];
            }
            
            [self.textTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)endRefreshing{
    
    if ([self.textTableView.mj_header isRefreshing]) {
        [self.textTableView.mj_header endRefreshing];
    }
    
    if ([self.textTableView.mj_footer isRefreshing]) {
        [self.textTableView.mj_footer endRefreshing];
    }
}

#pragma mark - getter


-(NSMutableArray *)cellFrames{
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

-(UITableView *)textTableView{
    
    if (!_textTableView) {
        _textTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _textTableView.dataSource = self;
        _textTableView.delegate = self;
        CGRect rect = self.view.bounds;
        _textTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, kScreenHeight-64-49);
        [self.view addSubview:_textTableView];
        /*
        [_textTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        */
        
    }
    
    return _textTableView;
}

@end
