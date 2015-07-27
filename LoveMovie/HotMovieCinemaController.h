//
//  HotMovieCinemaController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/26.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "SofCinemaModel.h"
#import "CinemaDetailCell.h"


@interface HotMovieCinemaController : BaseViewController

@property (nonatomic) int cinemaId ;
@property (nonatomic) int movieId ;
@property (nonatomic,copy) NSString * cinemaName;

@property (nonatomic,strong) UITableView * tableView;


@end
