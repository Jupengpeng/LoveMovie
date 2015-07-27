//
//  CinemaDetailController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "CinemaDetailCell.h"
#import "CinemaDetailModel.h"
#import "SofCinemaModel.h"
#import "MovieInHeaderModel.h"
#import "CinemaInHeaderModel.h"
#import "CInemaHeaderModel.h"
#import "UIButton+WebCache.h"
@interface CinemaDetailController : BaseViewController


@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic)int cinemaId ;

@property (nonatomic,strong) CInemaHeaderModel * headerModel;

@property (nonatomic)NSInteger currentTag ;

@property (nonatomic,strong)UILabel * dateLabel;

@property (nonatomic,copy) NSString * currentDate;

@end
