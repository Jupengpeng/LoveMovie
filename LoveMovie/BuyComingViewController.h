//
//  BuyComingViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ComingMovieModel.h"
#import "BuyComingModel.h"
#import "ComingVideoModel.h"
#import "ComingMovCell.h"
#import "ComingHeaderCell.h"
@interface BuyComingViewController : BaseViewController

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) BuyComingModel * comingModel;

@property (nonatomic) int  currentCityId;



@end
