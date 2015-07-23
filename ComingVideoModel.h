//
//  ComingVideoModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ComingVideoModel : BaseModel

@property (nonatomic)int videoId ;
@property (nonatomic)int length ;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * hightUrl;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * title;

//"videoId": 55027,
//"url": "http://vfx.mtime.cn/Video/2015/07/08/mp4/150708091128612480_480.mp4",
//"hightUrl": "http://vfx.mtime.cn/Video/2015/07/08/mp4/150708091128612480.mp4",
//"image": "http://img31.mtime.cn/mg/2015/07/08/091052.57753397.jpg",
//"length": 97,
//"title": "命中注定 终极版预告片"


@end
