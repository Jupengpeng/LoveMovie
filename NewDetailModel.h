//
//  NewDetailModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface NewDetailModel : BaseModel

@property (nonatomic) int type ;
@property (nonatomic) int id ;
@property (nonatomic) int commentCount ;
@property (nonatomic) int nextNewsID ;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * title2;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * time;
@property (nonatomic,copy) NSString * source;
@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * editor;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * wapUrl;
@property (nonatomic,strong) NSArray * relations;
@property (nonatomic,strong) NSArray * images;
@end
