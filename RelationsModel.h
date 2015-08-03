//
//  RelationsModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface RelationsModel : BaseModel

//共有

@property (nonatomic) int type ;
@property (nonatomic) int id ;
@property (nonatomic) int rating ;
@property (nonatomic) int scoreCount ;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * year;


//电影
@property (nonatomic,copy) NSString * releaseDate;
@property (nonatomic,copy) NSString * relaseLocation;

//影人
@property (nonatomic,copy) NSString * nameEn;





@end
