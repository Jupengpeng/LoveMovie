//
//  ReviewDetaiObjModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ReviewDetaiObjModel : BaseModel


@property (nonatomic) int type ;
@property (nonatomic) int id ;
@property (nonatomic) int rating ;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * titleCn;
@property (nonatomic,copy) NSString * titleEn;
@property (nonatomic,copy) NSString * runtime;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * wapUrl;
@property (nonatomic,copy) NSString * releaseDate;
@property (nonatomic,copy) NSString * releaseLocation;







@end
