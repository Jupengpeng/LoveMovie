//
//  seatModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/25.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface seatModel : BaseModel

@property (nonatomic)int id ;
@property (nonatomic)int x ;
@property (nonatomic)int y ;
@property (nonatomic)int type ;
@property (nonatomic,strong) NSString * name;
@property (nonatomic) BOOL status;
@property (nonatomic,copy) NSString * seatNumber;




@end
