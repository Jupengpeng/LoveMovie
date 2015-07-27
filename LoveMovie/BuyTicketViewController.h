//
//  BuyTicketViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "BuyCinemaViewController.h"
#import "BuyMovieViewController.h"
#import "LocationViewController.h"

@interface BuyTicketViewController : BaseViewController



@property (nonatomic,strong) NSMutableArray * movieDataArr;

@property (nonatomic,strong) NSMutableArray * cinemaArr;

@property (nonatomic,strong) UISegmentedControl * segmentControl;

@property (nonatomic) BuyMovieViewController *  movieViewController;

@property (nonatomic) BuyCinemaViewController *  cinemaViewController;

@property (nonatomic,copy) NSString * locationUrl;;

@property (nonatomic)int currentCityId ;

@property (nonatomic,strong) UIBarButtonItem * locationBtn;

@end
