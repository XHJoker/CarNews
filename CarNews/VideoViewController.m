//
//  VideoViewController.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "VideoViewController.h"

#import <MJRefresh.h>
#import "VideoCell.h"
#import "VideoCellFrame.h"
#import "CNVideoRequest.h"
#import <Masonry.h>
#import "WMPlayer.h"
#import "EdtMacro.h"

@interface VideoViewController ()<UITableViewDelegate,UITableViewDataSource,VideoCellPlayDelegate,WMPlayerDelegate>
@property (nonatomic,weak) UITableView *videoTableView;
@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic, weak) CNVIdeoImageView *imageView;
@end

@implementation VideoViewController
{
    WMPlayer *wmPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"视频";
    [self setMJRefresh];
    [self.videoTableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMJRefresh{
    
    self.videoTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.videoTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
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
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    
    if (!cell) {
        cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"videoCell"];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins= UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    VideoCellFrame *frame = self.cellFrames[indexPath.row];
    cell.delegate = self;
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
    
    VideoCellFrame *frame = self.cellFrames[indexPath.row];
    return frame.cellHeight;
}

#pragma mark cellDelegate

-(void)videoTableViewCell:(VideoCell *)cell didClickPlayBtnWithVideoUrl:(NSString *)videoUrl videoCover:(CNVIdeoImageView *)videoImageView{
    
    if (wmPlayer) {
        [self releaseWMPlayer];
    }
    
    self.imageView = videoImageView;
    wmPlayer = [[WMPlayer alloc]initWithFrame:videoImageView.bounds];
    wmPlayer.delegate = self;
    wmPlayer.closeBtnStyle = CloseBtnStyleClose;
    wmPlayer.URLString = videoUrl;
    [videoImageView addSubview:wmPlayer];
    [wmPlayer play];

}

#pragma mark -toFull

- (void)toCell {
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = self.imageView.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self.imageView addSubview:wmPlayer];
        [self.imageView bringSubviewToFront:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.fullScreenBtn.selected = NO;
    }];
    wmPlayer.isFullscreen = NO;
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation {
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    } else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-kScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(45);
        make.right.equalTo(wmPlayer.topView).with.offset(-45);
        make.center.equalTo(wmPlayer.topView);
        make.top.equalTo(wmPlayer.topView).with.offset(0);
    }];
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    wmPlayer.fullScreenBtn.selected = YES;
    
    wmPlayer.isFullscreen = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}


/** 隐藏状态栏*/

-(void)upDateStatusBarState{
    
    if (wmPlayer.isFullscreen) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
}

#pragma mark -WMPlayerDelegate

/** 点击关闭*/

- (void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn {
    if (wmplayer.isFullscreen) {
        wmplayer.isFullscreen = NO;
        [self toCell];
    } else {
        [self releaseWMPlayer];
    }
    
}

/** 点击全屏*/

- (void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn {
    if (fullScreenBtn.isSelected) {//全屏显示
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        [self toCell];
    }
    
    [self upDateStatusBarState];
}

- (void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}

- (void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

- (void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state {
    NSLog(@"wmplayerDidFailedPlay");
}

- (void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state {
    NSLog(@"wmplayerDidReadyToPlay");
}

- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer {
    //self.isSmallScreen = YES;
    [self releaseWMPlayer];
    [self upDateStatusBarState];
}

#pragma mark -releaseWMPlayer

- (void)releaseWMPlayer {
    
    [wmPlayer pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}



#pragma mark - Refresh

-(void)refreshData{
    
    CNVideoRequest *request = [CNVideoRequest cn_Request];
    request.baseUrl = @"http://c.m.163.com/nc/video/home/%ld-10.html";
    [request cn_VideoRefreshDataCompletion:^(id response, BOOL success, NSError *error) {
        if (success) {
            [self.cellFrames removeAllObjects];
            for (VideoModel *videoModel in response) {
                VideoCellFrame *frame = [[VideoCellFrame alloc] init];
                frame.model = videoModel;
                [self.cellFrames addObject:frame];
            }
            
            [self.videoTableView reloadData];
        }
        [self endRefreshing];
    }];
}

-(void)loadMoreData{
    
    CNVideoRequest *request = [CNVideoRequest cn_Request];
    request.baseUrl = @"http://c.m.163.com/nc/video/home/%ld-10.html";
    [request cn_VideoLoadMoreDataCompletion:^(id response, BOOL success, NSError *error) {
        if (success) {
            
            for (VideoModel *videoModel in response) {
                VideoCellFrame *frame = [[VideoCellFrame alloc] init];
                frame.model = videoModel;
                [self.cellFrames addObject:frame];
            }
            
            [self.videoTableView reloadData];
        }
        
        [self endRefreshing];
    }];
}

-(void)endRefreshing{
    
    if ([self.videoTableView.mj_header isRefreshing]) {
        [self.videoTableView.mj_header endRefreshing];
    }
    
    if ([self.videoTableView.mj_footer isRefreshing]) {
        [self.videoTableView.mj_footer endRefreshing];
    }
}

#pragma mark - getter


-(NSMutableArray *)cellFrames{
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

-(UITableView *)videoTableView{
    if (!_videoTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        _videoTableView = tableView;
    }
    
    return _videoTableView;
}

@end
