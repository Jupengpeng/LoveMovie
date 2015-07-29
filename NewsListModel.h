//
//  NewsListModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface NewsListModel : BaseModel

@property (nonatomic) int id ;
@property (nonatomic) int publishTime ;
@property (nonatomic) int commentCount ;
@property (nonatomic) int type ;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * title2;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy) NSString * summaryInfo;
@property (nonatomic,copy) NSString * tag;
@property (nonatomic,strong) NSArray * images;


//"id": 1545095,
//"type": 1,
//"image": "http://img31.mtime.cn/mg/2015/07/28/110843.44004403.jpg",
//"title": "\"太平轮\"耗时6年斥资4亿",
//"title2": "吴宇森为拍水中场景曾向李安取经",
//"summary": "太平轮,彼岸",
//"summaryInfo": "吴宇森为拍水中场景曾向李安取经",
//"tag": "无",
//"publishTime": 1438081996,
//"commentCount": 74,
//"images"


@end
