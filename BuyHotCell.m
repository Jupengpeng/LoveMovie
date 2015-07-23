//
//  BuyHotCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyHotCell.h"

@implementation BuyHotCell

- (void)awakeFromNib {

    self.iconImageView.clipsToBounds= YES;
    [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];

}




- (void)showDataWithMsModel:(BuyMsModel *)msModel{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:msModel.img] placeholderImage:[UIImage imageNamed:@"empty"]];
    self.titleLabel.text = msModel.tCn;
    self.specialLabel.text = [NSString stringWithFormat:@"“%@",msModel.commonSpecial];
    self.specialLabel.textColor = [UIColor orangeColor];
    self.upTimeLabel.text = [self transformTimeWithStr:msModel.rd];
    self.countLanel.text  = [NSString stringWithFormat:@"今日%d家影院 %d场",msModel.NearestCinemaCount,msModel.NearestShowtimeCount];
}

//购买按钮
- (IBAction)buyBtnClick:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)transformTimeWithStr:(NSString *)timeStr{
    NSString * m = nil;
    NSString * d = nil;
    m = [timeStr substringWithRange:NSMakeRange(4, 2)];
    d = [timeStr substringWithRange:NSMakeRange(6, 2)];
    
    return [NSString stringWithFormat:@"%@月%@日上映",m,d];
    
    
    
}
@end
