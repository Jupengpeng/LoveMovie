//
//  SortBoardModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface SortBoardModel : BaseModel


@property (nonatomic) int id ;
@property (nonatomic) int type ;
@property (nonatomic,copy) NSString * topListNameCn;
@property (nonatomic,copy) NSString * summary;

//"id": 1302,
//"topListNameCn": "BBC评选100部最伟大的美国电影",
//"topListNameEn": "",
//"type": 0,
//"summary": "《公民凯恩》力压《教父》获第一。

@end
