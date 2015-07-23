//
//  HomeHotCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHotPointCell : UITableViewCell
- (void)getMoreHotPointUrl:(NSString * )url;
@property (weak, nonatomic) IBOutlet UIButton *getMoreHotPointsBtn;

@end
