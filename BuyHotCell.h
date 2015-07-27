//
//  BuyHotCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyMsModel.h"
#import "UIImageView+WebCache.h"
typedef void (^HotMovieBlock) (int movieId);

@interface BuyHotCell : UITableViewCell
{
    HotMovieBlock _myBolck;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *specialLabel;

@property (weak, nonatomic) IBOutlet UILabel *upTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLanel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

- (void)showDataWithMsModel:(BuyMsModel *)msModel;

- (void)setMyBlock:(HotMovieBlock)myBlock;

@end
