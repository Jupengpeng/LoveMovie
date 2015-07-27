//
//  BuyCinemaCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"
#import "CinemaFeatureModel.h"

typedef void (^ShowCinemaBlock) (void);

@interface BuyCinemaCell : UITableViewCell
{
    ShowCinemaBlock _myBlock;
}
@property (weak, nonatomic) IBOutlet UIButton *ticketButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (nonatomic) float distance;

@property (nonatomic) CLLocationCoordinate2D myCoordinate;

- (void)setMyBlock:(ShowCinemaBlock)myBlock;

- (void)showCinemaDataWithModel:(CinemaModel *)cinemaModel;

- (void)showCSDataWithModel:(CinemaModel*)cinemaModel;

@end
