//
//  BuyHotViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "BuyHotMovieModel.h"
#import "BuyMsModel.h"
#import "BuyHotCell.h"
#import "BuyMovieDetailController.h"
#import "MyMovieDetailController.h"
@interface BuyHotViewController : BaseViewController

@property (nonatomic) int  currentCityId;



@property (nonatomic,strong) UITableView * hotTableView;

@property (nonatomic) CLLocationCoordinate2D myCoordinate;


@end
