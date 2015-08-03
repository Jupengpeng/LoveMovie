//
//  TopListdDetailViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "TopPersonModel.h"
@interface TopListdDetailViewController : BaseViewController

@property (nonatomic) int boradId; ;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;

@property (nonatomic) int currentPage ;

@end
