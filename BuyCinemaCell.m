//
//  BuyCinemaCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyCinemaCell.h"

@implementation BuyCinemaCell

- (void)awakeFromNib {



}

- (void)initMyCell{
    
    
    
    
}
//影院cell
- (void)showCinemaDataWithModel:(CinemaModel *)cinemaModel{
        self.ticketButton.hidden= YES;
    
    
    if (cinemaModel.minPrice) {
        self.priceLabel.hidden=NO;

//价格
    NSString * priceText = [NSString stringWithFormat:@"￥%d起",cinemaModel.minPrice/100];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:priceText];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,4) ];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(1, [attributeStr length]-2)];
    self.priceLabel.attributedText = attributeStr;
    }else{
        self.priceLabel.hidden=YES;
    }
    self.nameLabel.text = cinemaModel.cinameName;
//获取当前位置到目标经纬的距离

    NSString * locatonText = [NSString stringWithFormat:@"%@ %.1fkm",cinemaModel.address,cinemaModel.distance];
    self.locationLabel.text= locatonText;
    
    
}

//热映电影cell
- (void)showCSDataWithModel:(CinemaModel *)cinemaModel{

    if (cinemaModel.minPrice) {
        self.priceLabel.hidden=NO;
        
        //价格
        NSString * priceText = [NSString stringWithFormat:@"￥%d起",cinemaModel.minPrice/100];
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:priceText];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,4) ];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(1, [attributeStr length]-2)];
        self.priceLabel.attributedText = attributeStr;
    }else{
        self.priceLabel.hidden=YES;
    }
    self.nameLabel.text = cinemaModel.cn;
    //获取当前位置到目标经纬的距离
    
    NSString * locatonText = [NSString stringWithFormat:@"%@ %.1fkm",cinemaModel.address,cinemaModel.distance];
    self.locationLabel.text= locatonText;
    
    
    
}
//看票按钮点击
- (IBAction)ticketClick:(id)sender {
    
    if (_myBlock) {
        _myBlock();
    }
    
    
}

- (void)setMyBlock:(ShowCinemaBlock)myBlock{
    if (_myBlock != myBlock) {
        _myBlock = [myBlock copy];
    }
    
}


- (double)getDistanceFrome:(CLLocationCoordinate2D)origCoordonate toDistWithLatitude:(CLLocationDegrees)latitude Longitude:(CLLocationDegrees)longitude{
    
    CLLocation * orig = [[CLLocation alloc] initWithLatitude:origCoordonate.latitude  longitude:origCoordonate.longitude];
    CLLocation * dist = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];

    CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
    
    return kilometers;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
