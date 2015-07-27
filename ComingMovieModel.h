//
//  ComingMovieModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ComingMovieModel : BaseModel

@property (nonatomic)int id ;
@property (nonatomic)int rYear ;
@property (nonatomic)int rMonth ;
@property (nonatomic)int rDay ;
@property (nonatomic)int wantedCount ;
@property (nonatomic)int videoCount ;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * releaseDate;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * director;
@property (nonatomic,copy) NSString * actor1;
@property (nonatomic,copy) NSString * actor2;
@property (nonatomic,copy) NSString * locationName;
@property (nonatomic) BOOL isTicket;
@property (nonatomic,strong) NSArray * videos;


//id": 212016,
//"title": "命中注定",
//"image": "http://img31.mtime.cn/mt/2015/07/08/092845.40548669_1280X720X2.jpg",
//"releaseDate": "7月24日上映",
//"rYear": 2015,
//"rMonth": 7,
//"rDay": 24,
//"type": "爱情 | 喜剧",
//"director": "张皓",
//"actor1": "汤唯",
//"actor2": "廖凡",
//"locationName": "中国",
//"isTicket": true,
//"wantedCount": 1671,
//"videoCount": 3,
//"videos":

@end
