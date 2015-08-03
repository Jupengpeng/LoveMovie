//
//  ReviewCell.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewModel.h"
#import "UIImageView+WebCache.h"
#import "ReviewObjModel.h"
@interface ReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImaheView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewerLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)showDataWithReviewModel:(ReviewModel *)model;

@end
