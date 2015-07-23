//
//  HomeAreaSecondModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "HomesubFirstModel.h"
#import "HomesubSecondModel.h"
#import "HomesubThreeModel.h"
#import "HomesubFiourModel.h"
#import "HomesubFiveModel.h"

@interface HomeAreaSecondModel : JSONModel

@property (nonatomic,strong) HomesubFirstModel * subFirst;
@property (nonatomic,strong) HomesubSecondModel * subSecond;
@property (nonatomic,strong) HomesubThreeModel *  subThird;
@property (nonatomic,strong) HomesubFiourModel * subFourth;
@property (nonatomic,strong) HomesubFiveModel * subFifth;

@end
