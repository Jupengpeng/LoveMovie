//
//  HomeHeaderMovieModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-18.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface HomeHeaderMovieModel : BaseModel

@property (nonatomic)int  movieId;
@property (nonatomic)float ratingFinal;
@property (nonatomic)int length;
@property (nonatomic)int rYear;
@property (nonatomic)int rMonth;
@property (nonatomic)int wantedCount;
@property (nonatomic)int rDay;
@property (nonatomic,copy) NSString * titleCn;
@property (nonatomic,copy) NSString * titleEn;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * directorName;
@property (nonatomic,copy) NSString * actorName1;
@property (nonatomic,copy) NSString * actorName2;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * commonSpecial;
@property (nonatomic) BOOL isNew;
@property (nonatomic) BOOL isHot;
@property (nonatomic) BOOL is3D;
@property (nonatomic) BOOL isIMAX;
@property (nonatomic) BOOL isIMAX3D;
@property (nonatomic) BOOL isDMAX;
@property (nonatomic,copy) NSDictionary * nearestShowtime;





@end
