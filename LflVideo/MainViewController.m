//
//  MainViewController.m
//  LflVideo
//
//  Created by Yomoo on 2017/12/20.
//  Copyright © 2017年 Yomoo. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "LflVideoCell.h"
#import "LflVideoPlayer.h"
#import "LflVideoItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#define videoListUrl @"http://c.3g.163.com/nc/video/list/VAP4BFR16/y/0-10.html"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{
    NSIndexPath *_indexPath;
    LflVideoPlayer *_player;
    CGRect _currentPlayCellRect;
}
@property(nonatomic,strong)UITableView *exampleTableView;
@property (nonatomic, strong) NSMutableArray *videoArray;
@end

@implementation MainViewController
- (NSMutableArray *)videoArray {
    if (!_videoArray) {
        _videoArray = [NSMutableArray array];
    }
    return _videoArray;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_player destroyPlayer];
    _player = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _exampleTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _exampleTableView.delegate=self;
    _exampleTableView.dataSource=self;
    _exampleTableView.rowHeight=300;
    _exampleTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_exampleTableView];
    [_exampleTableView registerClass:[LflVideoCell class] forCellReuseIdentifier:NSStringFromClass([LflVideoCell class])];
     [self fetchVideoListData];
}

#pragma mark - network

- (void)fetchVideoListData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:videoListUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //        NSLog(@"%@", responseObject);
        NSArray *dataArray = responseObject[@"VAP4BFR16"];
        for (NSDictionary *dict in dataArray) {
            [self.videoArray addObject:[LflVideoItem mj_objectWithKeyValues:dict]];
        }
        [self.exampleTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)showVideoPlayer:(UITapGestureRecognizer *)tapGesture {
    [_player destroyPlayer];
    _player = nil;
    
    UIView *view = tapGesture.view;
    LflVideoItem *item = self.videoArray[view.tag - 100];
    
    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
    LflVideoCell *cell = [self.exampleTableView cellForRowAtIndexPath:_indexPath];
    
    _player = [[LflVideoPlayer alloc] init];
    _player.videoUrl = item.mp4_url;
    [_player playerBindTableView:self.exampleTableView currentIndexPath:_indexPath];
    _player.frame = view.bounds;
    
    [cell.contentView addSubview:_player];
    
    _player.completedPlayingBlock = ^(LflVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LflVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LflVideoCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LflVideoItem *item = self.videoArray[indexPath.row];
    cell.videoItem = item;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
    [cell.videoImageView addGestureRecognizer:tap];
    cell.videoImageView.tag = indexPath.row + 100;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LflVideoItem *item = self.videoArray[indexPath.row];
    DetailViewController *videoDetailViewController = [[DetailViewController alloc] init];
    videoDetailViewController.videoTitle = item.title;
    videoDetailViewController.mp4_url = item.mp4_url;
    [self.navigationController pushViewController:videoDetailViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.exampleTableView]) {
        
        [_player playerScrollIsSupportSmallWindowPlay:NO];
    }
}
@end
