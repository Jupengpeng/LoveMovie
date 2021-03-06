//
//  BuyCinemaViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-20.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "JPControl.h"
#import "BuyCinemaModel.h"
#import "CinemaModel.h"
#import "BuyCinemaCell.h"
#import "CinemaDetailController.h"
@interface BuyCinemaViewController : BaseViewController

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic)NSInteger currentTag ;

@property (nonatomic,copy) NSString * allCinemaUrl;

@property (nonatomic,strong) NSMutableArray * cinemasArr;

@property (nonatomic,strong) NSMutableArray * distanceArr;

@property (nonatomic,strong) NSMutableArray * districtsArr;

@property (nonatomic,strong) NSMutableArray * emptyPriArr;

@property (nonatomic,strong) NSMutableArray * subwayCinemasArr;

@property (nonatomic)int currentCityId ;

@property (nonatomic) CLLocationCoordinate2D myCoordinate;

- (void)initData;

@end
