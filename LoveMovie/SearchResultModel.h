//
//  SearchResultModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface SearchResultModel : BaseModel

@property (nonatomic) int id ;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * nameEn;



@property (nonatomic,strong) NSArray * titleOthersCn;
@property (nonatomic,copy) NSString * movieType;
@property (nonatomic,copy) NSString * year;
@property (nonatomic,copy) NSString * rating;
@property (nonatomic,copy) NSString * locationName;

//人物
@property (nonatomic) float loveDeep ;
@property (nonatomic,copy) NSString * profession;
@property (nonatomic,strong) NSArray * personMovies;

//"id": 2050383,
//"name": "绿妖",
//"img": "http://img31.mtime.cn/ph/383/2050383/2050383_1280X720X2.jpg",
//"nameEn": "Yao Lv",
//"sex": "女",
//"birthday": "",
//"profession": "编剧",
//"constellation": "",
//"birthLocation": "",
//"rating": -1,
//"loveDeep": -1
//
//"id": 211794,
//"name": "捉妖记",
//"nameEn": "Monster Hunt",
//"movieType": "奇幻 | 喜剧",
//"img": "http://img31.mtime.cn/mt/2015/06/24/095659.10934613_1280X720X2.jpg",
//"titleOthersCn": [
//                  "聊斋之宅妖"

@end
