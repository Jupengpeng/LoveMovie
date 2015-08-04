//
//  BuyMovieViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-20.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "BuyHotViewController.h"
#import "BuyComingViewController.h"
@interface BuyMovieViewController : BaseViewController

@property (nonatomic) int  currentCityId;

@property (nonatomic) CLLocationCoordinate2D myCoordinate;

@property (nonatomic) BuyHotViewController * hotController ;

@property (nonatomic,strong) BuyComingViewController * comingController;
- (void)initSubControllers;

@end
