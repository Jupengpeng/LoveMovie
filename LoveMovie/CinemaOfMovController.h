//
//  CinemaOfMovController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/25.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "seatModel.h"
#import "InCinemaModel.h"
@interface CinemaOfMovController : BaseViewController

@property (nonatomic,strong)NSNumber * myDId ;

@property (nonatomic,strong) UILabel * hallLabel;

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UILabel * currentSeat;

@property (nonatomic,strong) UILabel * cinemaLabel;

@property (nonatomic,strong) UILabel * leftSeatsLabel;

@end
