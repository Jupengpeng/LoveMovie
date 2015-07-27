//
//  CinemaDetailCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SofCinemaModel.h"
#import "JPControl.h"
#import "CinemaOfMovController.h"
@interface CinemaDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriLabel;
@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *hallIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (nonatomic,strong) UINavigationController * niv;

@property (nonatomic,strong)NSNumber * dId ;

- (void)showDataWithSModel:(SofCinemaModel *)model;


@end
