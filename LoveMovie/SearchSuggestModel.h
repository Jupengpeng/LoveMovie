//
//  searchSuggestModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface SearchSuggestModel : BaseModel
//共有

@property (nonatomic) int id ;
@property (nonatomic) int type ;


@property (nonatomic,copy) NSString * titlecn;
@property (nonatomic,copy) NSString * titleen;
@property (nonatomic,copy) NSString * cover;

//电影
@property (nonatomic,copy) NSString * contentType;
@property (nonatomic,copy) NSString * movieType;
@property (nonatomic,copy) NSString * rLocation;
@property (nonatomic,copy) NSString * locationName;
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * director;
//人物
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * birthLocation;

@property (nonatomic,copy) NSString * profession;
@property (nonatomic,copy) NSString * birth;




@end
