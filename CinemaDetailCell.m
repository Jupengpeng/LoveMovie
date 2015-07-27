//
//  CinemaDetailCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "CinemaDetailCell.h"

@implementation CinemaDetailCell

- (void)awakeFromNib {
}

- (void)showDataWithSModel:(SofCinemaModel *)model{
    self.hallIdLabel.text = model.hall;
    self.currentPriLabel.text =[NSString stringWithFormat:@"￥%d" ,model.salePrice/100];
    self.oriPriceLabel.text = [NSString stringWithFormat:@"￥%d",model.cinemaPrice/100];
    self.typeLabel.text = [NSString stringWithFormat:@"%@/%@",model.versionDesc,model.language];
    self.startTimeLabel.text = [JPControl transformToHourWithMinutes:model.spaceTime];
    
    int overTime = model.spaceTime + model.length;
    self.endLabel.text = [NSString stringWithFormat:@"%@散场" ,[JPControl transformToHourWithMinutes:overTime]];
    
    NSDictionary * dict = model.provider[0];
    self.dId =dict[@"dId"];
    
}
- (IBAction)buyClick:(id)sender {
    
    CinemaOfMovController * cVC = [[CinemaOfMovController alloc]init];
    cVC.myDId = self.dId;
    [self.niv pushViewController:cVC animated:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
