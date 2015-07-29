//
//  MallViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "UIButton+WebCache.h"
#import "MarketModel.h"
#import "MarketFirstCell.h"
#import "FourCateCell.h"
#import "SubViewCell.h"
#import "MiddleHeroesCell.h"
#import "CateDetailCell.h"
#import "RecommendCell.h"
@interface MallViewController : BaseViewController

@property (nonatomic,strong) MarketModel * marketModel;

@property (nonatomic,strong) UICollectionView * myCollectionView;

@end
