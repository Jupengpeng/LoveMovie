//
//  ComingHeaderCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComingMovieModel.h"
#import "UIImageView+WebCache.h"
@interface ComingHeaderCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wantedLanel;

@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;
@property (weak, nonatomic) IBOutlet UIButton *foreshowButton;

- (void)showHeaderDataWithMovieModel:(ComingMovieModel *)movieModel;


@end
