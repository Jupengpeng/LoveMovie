//
//  HomeHotType1Cell.h
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
#import "NewsImageModel.h"
@interface HomeHotType1Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

- (void)showDataWithHomeHotPointModel:(HomeHotPointModel *)model;

- (void)showDataWithNewsListModel:(NewsListModel *)model;

@end
