//
//  MovieInHeaderModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface MovieInHeaderModel : BaseModel

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * titleEn;
@property (nonatomic,copy) NSString * length;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * img;
@property (nonatomic)int movieId ;
@property (nonatomic) float ratingFinal;
@property (nonatomic,strong) NSArray * showDates;




@end
