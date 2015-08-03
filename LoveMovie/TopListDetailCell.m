//
//  TopListDetailCell.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/30.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "TopListDetailCell.h"
#import "UIImageView+WebCache.h"
@implementation TopListDetailCell

- (void)awakeFromNib {
    self.ratingLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.adjustsFontSizeToFitWidth=YES;
}
-(void)showDataWithModel:(TopMoveModel *)model withIndexPath:(NSIndexPath *)path{
    self.rankNum.text=[NSString stringWithFormat:@"%02d",model.rankNum.intValue];
    self.rankNum.font=[UIFont systemFontOfSize:15];
    self.rankNum.layer.masksToBounds=YES;
    self.rankNum.layer.cornerRadius=10;
    self.rankNum.textAlignment=NSTextAlignmentCenter;
    self.rankNum.textColor = [UIColor whiteColor];
    if (path.row==0) {
        self.rankNum.backgroundColor=[UIColor orangeColor];
    }else if (path.row==1){
    self.rankNum.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.4f];
    }else if (path.row==2){
    self.rankNum.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.4];
    }else{
    self.rankNum.backgroundColor=myLight;
    }
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:model.posterUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text=model.name;
    self.nameEnLabel.text=model.nameEn;
    self.directorLabel.text=model.director;
    self.actorLabel.text=model.actor;
    self.releaseDateLabel.text=[NSString stringWithFormat:@"%@   %@",model.releaseDate,model.releaseLocation];
    self.remarkLabel.text=model.remark;
    if (model.rating>0) {
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",model.rating];

    }else{
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",0-model.rating];

    }
}
-(void)showDataWithPersonModel:(TopPersonModel *)model withIndexPath:(NSIndexPath *)path{

    self.rankNum.text=[NSString stringWithFormat:@"%02d",model.rankNum];
    self.rankNum.font=[UIFont systemFontOfSize:15];
    self.rankNum.layer.masksToBounds=YES;
    self.rankNum.layer.cornerRadius=10;
    self.rankNum.textAlignment=NSTextAlignmentCenter;
    self.rankNum.textColor = [UIColor whiteColor];
    if (path.row==0) {
        self.rankNum.backgroundColor=[UIColor orangeColor];
    }else if (path.row==1){
        self.rankNum.backgroundColor=[[UIColor blueColor]colorWithAlphaComponent:0.4f];
    }else if (path.row==2){
        self.rankNum.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.4];
    }else{
        self.rankNum.backgroundColor=myLight;
    }
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:model.posterUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text=model.nameCn;
    self.nameEnLabel.text=model.nameEn;
    self.directorLabel.text=[NSString stringWithFormat:@"生于%d%@", model.birthYear,model.birthDay];
    self.actorLabel.text=[NSString stringWithFormat:@"籍贯:%@", model.birthLocation];
    self.releaseDateLabel.text = [NSString stringWithFormat:@"星座:%@",model.constellation];
    self.remarkLabel.text=model.summary;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f",model.rating];



}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
