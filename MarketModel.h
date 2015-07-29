//
//  MarketModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "scrollImgModel.h"
#import "navigatorIcon.h"
#import "navigatorFirthIcon.h"
#import "cellA.h"
#import "cellB.h"
#import "cellC.h"
#import "topic.h"
#import "category.h"
@interface MarketModel : JSONModel

@property (nonatomic,strong) NSArray<scrollImgModelDelegate,Optional> * scrollImg;
@property (nonatomic,strong) NSArray<navigatorIconDelegate,Optional> * navigatorIcon;
@property (nonatomic,strong) navigatorFirthIcon<Optional> * navigatorFirthIcon;
@property (nonatomic,strong) cellA<Optional> * cellA;
@property (nonatomic,strong) cellB<Optional> * cellB;
@property (nonatomic,strong) cellC<Optional> * cellC;
@property (nonatomic,strong) NSArray<topicDelegate,Optional> * topic;
@property (nonatomic,strong) NSArray<categoryDelegate,Optional> * category;


@end
