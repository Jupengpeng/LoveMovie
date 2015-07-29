//
//  ReviewModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ReviewModel : BaseModel

@property (nonatomic) int id ;
@property (nonatomic,copy) NSString * nickname;
@property (nonatomic,copy) NSString * userImage;
@property (nonatomic,copy) NSString * rating;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * summary;
//"id": 7905596,
//"nickname": "Cydeny",
//"userImage": "http://img32.mtime.cn/up/2013/01/08/081313.64016596_128X128.jpg",
//"rating": "8.3",
//"title": "请守住那份伟大的单纯",
//"summary": "在CG动画一统江湖的时代，能把黏土动画拍得如此充满魅力而又优雅的，或许也只有业界良心阿德曼了



@end
