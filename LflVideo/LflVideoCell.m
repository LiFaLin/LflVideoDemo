//
//  LflVideoCell.m
//  LflVideo
//
//  Created by Yomoo on 2017/12/20.
//  Copyright © 2017年 Yomoo. All rights reserved.
//

#import "LflVideoCell.h"
#import <UIImageView+WebCache.h>
@implementation LflVideoCell
-(UIImageView*)videoImageView{
    if (!_videoImageView) {
        _videoImageView=[[UIImageView alloc]init];
        _videoImageView.userInteractionEnabled=YES;
        [self.contentView addSubview:_videoImageView];
    }
    return _videoImageView;
}
-(UIImageView*)NextImageView{
    if (!_NextImageView) {
        _NextImageView=[[UIImageView alloc]init];
        _NextImageView.image=[UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_NextImageView];
    }
    return _NextImageView;
}
-(UILabel*)videoTitle{
    if (!_videoTitle) {
        _videoTitle=[[UILabel alloc]init];
        _videoTitle.font=[UIFont systemFontOfSize:15];
        _videoTitle.numberOfLines=0;
        _videoTitle.textColor=[UIColor grayColor];
        [self.contentView addSubview:_videoTitle];
    }
    return _videoTitle;
}
-(void)layoutSubviews{
//    [self layoutSubviews];
    float width =self.bounds.size.width;
    self.videoImageView.frame=CGRectMake(0, 0, width, 250);
    self.videoTitle.frame=CGRectMake(10, 250, width-30, 50);
    self.NextImageView.frame=CGRectMake(width-20, 270, 10, 10);
}
- (void)setVideoItem:(LflVideoItem *)videoItem {
    _videoItem = videoItem;
    self.videoTitle.text = videoItem.title;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:videoItem.cover]];
}

@end
