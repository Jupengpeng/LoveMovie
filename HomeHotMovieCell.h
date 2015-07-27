//
//  HomeHotMovieCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHotMovieModel.h"
#import "UIImageView+WebCache.h"
@interface HomeHotMovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleCnLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleEnLabel;

@property (weak, nonatomic) IBOutlet UIImageView *littleImageView;

- (void)showDataWithHomeHotMovieModel:(HomeHotMovieModel *)model;




@end
