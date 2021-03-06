//
//  FindViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "NewsHeaderModel.h"
#import "TrailerHeaderModel.h"
#import "TopListHeaderModel.h"
#import "ReviewHeaderModel.h"
#import "NewsListModel.h"
#import "ForeDisPlayModel.h"
#import "SortBoardModel.h"
#import "ReviewHeaderModel.h"
#import "HomeHotType1Cell.h"
#import "HomeHotType2Cell.h"
#import "LZXHelper.h"
#import "ReviewCell.h"
#import "NewsDetailViewController.h"
#import "ForedisplayDetailController.h"
#import "TopListdDetailViewController.h"
#import "ReviewDetailViewController.h"
@interface FindViewController : BaseViewController

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,copy) NSString * head;

@property (nonatomic,copy) NSString * url;

@property (nonatomic,copy) NSString * type;

@property (nonatomic,strong) NewsHeaderModel * newsHeaderModel;
@property (nonatomic,strong) TrailerHeaderModel * trailerHeaderModel;
@property (nonatomic,strong) TopListHeaderModel * topListHeaderModel;
@property (nonatomic,strong) ReviewHeaderModel * reviewHeaderModel;

@property (nonatomic,strong)UIView * headerView;

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;

@property (nonatomic) int currentPage ;
- (void)createFooterRefresh;

- (void)createHeaderRefreshView;

@end
