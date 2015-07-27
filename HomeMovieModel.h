//
//  HomeMovieModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"

@interface HomeMovieModel : JSONModel



@property (nonatomic)int movieId ;
@property (nonatomic,copy) NSString * titleCn;
@property (nonatomic,copy) NSString * titleEn;
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * desc;
@property (nonatomic,copy) NSString * image;


//"movieId": 217325,
//"titleCn": "真实",
//"titleEn": "Réalité",
//"year": "2014",
//"desc": "法国鬼才导演新作，现实与梦境的无限转换，混乱表象下，却有大智慧。\n",
//"image": "http://img31.mtime.cn/mt/2015/01/22/090845.32988843_1280X720X2.jpg"
@end
