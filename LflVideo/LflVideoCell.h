//
//  LflVideoCell.h
//  LflVideo
//
//  Created by Yomoo on 2017/12/20.
//  Copyright © 2017年 Yomoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LflVideoItem.h"
@interface LflVideoCell : UITableViewCell
@property(nonatomic,strong)UIImageView *videoImageView;
@property(nonatomic,strong)UIImageView *NextImageView;
@property(nonatomic,strong)UILabel *videoTitle;
@property (nonatomic, strong) LflVideoItem *videoItem;

@end
