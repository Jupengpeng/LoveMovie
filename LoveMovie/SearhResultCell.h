//
//  SearhResultCell.h
//  LoveMovie
//
//  Created by qianfeng on 15/8/1.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultModel.h"
#import "UIImageView+WebCache.h"
@interface SearhResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleEn;
@property (weak, nonatomic) IBOutlet UILabel *moreInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *tpeLabel;


@property (weak, nonatomic) IBOutlet UIImageView *CoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (void)showDataWithResultModel:(SearchResultModel *)model;

@end
