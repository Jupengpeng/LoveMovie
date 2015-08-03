//
//  TopMoveModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"
/**
 "id": 210729,
 "name": "廷巴克图",
 "nameEn": "Timbuktu",
 "rankNum": 1,
 "posterUrl": "http://img31.mtime.cn/mt/2014/10/28/091513.98662952_1280X720X2.jpg",
 "decade": 2015,
 "rating": 7.1,
 "releaseDate": "2015年1月28日",
 "releaseLocation": "美国",
 "movieType": "剧情",
 "director": "阿德拉曼·希萨柯",
 "actor": "伊布拉西姆·艾哈迈德",
 "actor2": "图洛·吉吉",
 "remark": "metacritic评分：91 阿德拉曼·希萨柯这部热情、视觉美妙的影片是一声发自心灵的哭喊。——《卫报》"
 */
@interface TopMoveModel : BaseModel
@property(nonatomic)NSNumber * id;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * nameEn;
@property(nonatomic)NSNumber * rankNum;
@property(nonatomic,copy)NSString * posterUrl;
@property(nonatomic)NSNumber * decade;
@property(nonatomic)float  rating;
@property(nonatomic,copy)NSString * releaseDate;
@property(nonatomic,copy)NSString * releaseLocation;
@property(nonatomic,copy)NSString * movieType;
@property(nonatomic,copy)NSString * director;
@property(nonatomic,copy)NSString * actor;
@property(nonatomic,copy)NSString * actor2;
@property(nonatomic,copy)NSString * remark;
@end
