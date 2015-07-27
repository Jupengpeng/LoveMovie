//
//  BuyMovieDetailController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/26.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "TimeModel.h"
#import "CinemaModel.h"
#import "CinemaDetailController.h"
#import "BuyCinemaCell.h"
#import "MyControl.h"
#import "HotMovieCinemaController.h"
@interface BuyMovieDetailController : BaseViewController

@property (nonatomic) int locationId ;

@property (nonatomic) int movieId;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic) CLLocationCoordinate2D myCoordinate;

@property (nonatomic,strong) NSMutableArray *emptyPriArr;

@property (nonatomic,copy) NSString * movieName;

@end
