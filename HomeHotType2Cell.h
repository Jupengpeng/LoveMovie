//
//  HomeHotType2Cell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHotPointModel.h"
#import "HomeHotImageModel.h"
#import "UIImageView+WebCache.h"
#import "NewsListModel.h"
#import "ForeDisPlayModel.h"
@interface HomeHotType2Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic,strong)UIImageView * playIcon;

@property (nonatomic) UINavigationController * nivController;


- (void)showDataWithHomeHotPointModel:(HomeHotPointModel *)model;

- (void)showDataWithNewsListModel:(NewsListModel *)model;

- (void)showDataWithForeDisPlayModel:(ForeDisPlayModel *)model;

@end
