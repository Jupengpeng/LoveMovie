//
//  HomePageModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "HomeHotMovieModel.h"
#import "HomeAreaSecondModel.h"
#import "HomeAdvModel.h"
#import "HomeHotPointModel.h"


@interface HomePageModel : JSONModel

@property (nonatomic,strong) NSArray<HomeAdvModel>* advList;

@property (nonatomic,strong) NSArray<HomeHotPointModel> * hotPoints;
@property (nonatomic,strong) HomeHotMovieModel * hotMovie;
@property (nonatomic,strong) HomeAreaSecondModel * areaSecond;

//JSON
//
//advList
//hotPoints
//hotPerson
//hotMovie
//areaFirst
//areaSecond

@end
