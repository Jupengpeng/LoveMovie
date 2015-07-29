//
//  ForeDisPlayModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ForeDisPlayModel : BaseModel

@property (nonatomic) int id;
@property (nonatomic) int movieId ;
@property (nonatomic) int videoLength ;
@property (nonatomic) int rating ;
@property (nonatomic,copy) NSString * movieName;
@property (nonatomic,copy) NSString * coverImg;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * hightUrl;
@property (nonatomic,copy) NSString * videoTitle;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,strong) NSArray * type;

//"trailers": [
//             {
//                 "id": 55439,
//                 "movieName": "《谜城》终极版预告片",
//                 "coverImg": "http://img31.mtime.cn/mg/2015/07/27/100030.25080984.jpg",
//                 "movieId": 215630,
//                 "url": "http://vfx.mtime.cn/Video/2015/07/27/mp4/150727085840435673_480.mp4",
//                 "hightUrl": "http://vfx.mtime.cn/Video/2015/07/27/mp4/150727085840435673.mp4",
//                 "videoTitle": "谜城 终极预告片2",
//                 "videoLength": 102,
//                 "rating": -1,
//                 "type": [
//                          "动作",
//                          "剧情",
//                          "犯罪"
//                          ],
//                 "summary":金钱与人性、正义与邪恶之战

@end
