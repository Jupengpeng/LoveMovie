//
//  ReviewDetailModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ReviewDetailModel : BaseModel

@property (nonatomic) int id ;
@property (nonatomic) int commentCount ;


@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * userImage;
@property (nonatomic,copy) NSString * time;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * summaryInfo;
@property (nonatomic,copy) NSString * rating;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * topImgUrl;
@property (nonatomic,strong) NSArray * types;
@property (nonatomic,strong) NSDictionary * relatedObj;

//"id": 7905596,
//"nickname": "Cydeny",
//"userImage": "http://img32.mtime.cn/up/2013/01/08/081313.64016596_128X128.jpg",
//"commentCount": 24,
//"time": "2015-6-29 9:25",
//"title": "小羊肖恩：朋友啊，请你永远守住那份伟大的单纯",
//"url": "http://i.mtime.com/2455334/blog/7905596/",
//"content":
//summaryInfo
//rating
//type
//relatedObj
//topImgUrl


@end
