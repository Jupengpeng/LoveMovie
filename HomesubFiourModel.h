//
//  HomesubFiourModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "HomeGotoPageModel.h"
@interface HomesubFiourModel : JSONModel


@property (nonatomic)int goodsId ;

@property (nonatomic,copy) NSString * image;

@property (nonatomic,strong) HomeGotoPageModel * gotoPage;

@end
