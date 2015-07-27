//
//  CinemaInHeaderModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaInHeaderModel : BaseModel

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * tel;
@property (nonatomic)int cinemaId ;
@property (nonatomic)float longitude ;
@property (nonatomic)float latitude ;
@property (nonatomic)float baiduLongitude ;
@property (nonatomic)float baiduLatitude ;
@property (nonatomic,strong) NSDictionary * feature;

@end
