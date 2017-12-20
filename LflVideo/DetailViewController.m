//
//  DetailViewController.m
//  LflVideo
//
//  Created by Yomoo on 2017/12/20.
//  Copyright © 2017年 Yomoo. All rights reserved.
//

#import "DetailViewController.h"
#import "LflVideoPlayer.h"
@interface DetailViewController ()

@property (nonatomic, strong) LflVideoPlayer *player;
@end

@implementation DetailViewController

- (LflVideoPlayer *)player {
    if (!_player) {
        _player = [[LflVideoPlayer alloc] init];
        _player.frame = CGRectMake(0, 64, self.view.frame.size.width, 250);
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.videoTitle;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.player.videoUrl = self.mp4_url;
    [self.view addSubview:self.player];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.player destroyPlayer];
    self.player = nil;
}

@end
