//
//  TopPersonModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface TopPersonModel : BaseModel


@property (nonatomic) int id ;
@property (nonatomic) int rankNum ;
@property (nonatomic) float rating ;
@property (nonatomic) int birthYear ;
@property (nonatomic,copy) NSString * nameCn;
@property (nonatomic,copy) NSString * nameEn;
@property (nonatomic,copy) NSString * posterUrl;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * birthDay;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy) NSString * birthLocation;
@property (nonatomic,copy) NSString * constellation;

//
//"id": 917287,
//"nameCn": "张东健",
//"nameEn": "Dong-gun Jang",
//"rankNum": 1,
//"posterUrl": "http://img31.mtime.cn/ph/2014/05/06/113232.33741647_1280X720X2.jpg",
//"rating": 8.4,
//"sex": "男",
//"birthYear": 1972,
//"birthDay": "3月7日",
//"birthLocation": "韩国首尔",
//"constellation": "双鱼座",
//"summary": "笃信佛教的张东健在圈内是出名的“三好先生”，演技好、性格好、品行好。而他那张俊美无匹的脸，总能使人怦然心动。

@end
