//
//  ReviewCell.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "ReviewCell.h"

@implementation ReviewCell

- (void)awakeFromNib {
    self.iconLabel.layer.cornerRadius = 15.0f;
    self.iconLabel.clipsToBounds = YES;
}


- (void)showDataWithReviewModel:(ReviewModel *)model{
    ReviewObjModel * objModel = [[ReviewObjModel alloc]init];
    [objModel setValuesForKeysWithDictionary:model.relatedObj];
    
    self.titleLabel.text = model.title;
    //NSLog(@"%@%@", self.titleLabel, model.title);
    self.descLabel.text = model.summary;
    
    self.reviewerLabel.text = [NSString stringWithFormat:@"%@-评 《%@》",model.nickname,objModel.title ];
    self.reviewerLabel.adjustsFontSizeToFitWidth = YES;
    self.ratingLabel.text = objModel.rating;
    
    [self.iconLabel  sd_setImageWithURL:[NSURL URLWithString:model.userImage] placeholderImage:[UIImage imageNamed:@"empty"]];
    [self.coverImaheView sd_setImageWithURL:[NSURL URLWithString:objModel.image] placeholderImage:[UIImage imageNamed:@"empty"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];



}

@end
