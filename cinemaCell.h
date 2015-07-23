//
//  cinemaCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"
@interface cinemaCell : UITableViewCell

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * addressLabel;




- (void)showDataWithCinemaModel:(CinemaModel *)cineModel;

@end
