//
//  TopListDetailCell.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopMoveModel.h"
#import "TopPersonModel.h"
@interface TopListDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankNum;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameEnLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
-(void)showDataWithModel:(TopMoveModel *)model withIndexPath:(NSIndexPath *)path;
-(void)showDataWithPersonModel:(TopPersonModel *)model withIndexPath:(NSIndexPath *)path;
@end
