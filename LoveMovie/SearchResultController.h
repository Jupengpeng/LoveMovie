//
//  SearchResultController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "SearchResultModel.h"
#import "SearhResultCell.h"
@interface SearchResultController : BaseViewController

@property (nonatomic,copy) NSString * keyWords;

@property (nonatomic) UITableView * tableView;

@end
