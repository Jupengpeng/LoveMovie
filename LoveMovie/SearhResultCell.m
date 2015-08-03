//
//  SearhResultCell.m
//  LoveMovie
//
//  Created by qianfeng on 15/8/1.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "SearhResultCell.h"

@implementation SearhResultCell

- (void)awakeFromNib {
    self.CoverImageView.clipsToBounds= YES;
    [self.CoverImageView setContentMode:UIViewContentModeScaleAspectFill];
}


- (void)showDataWithResultModel:(SearchResultModel *)model{
    [self.CoverImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"empty"]];
    //如果是电影(判断好感度是否存在)
    if (!model.loveDeep) {
        if (model.year) {
            self.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",model.name,model.year];
            if (model.rating) {
                self.titleLabel.text = [NSString stringWithFormat:@"%@(%@)  %@",model.name,model.year,model.rating];
            }
        }else{
            self.titleLabel.text = [NSString stringWithFormat:@"%@",model.name];
        }
        
        self.titleEn.text = model.nameEn ? model.nameEn:@"" ;
        if (model.titleOthersCn) {
            NSMutableString * otherTitles = [NSMutableString stringWithString:  @"更多影片:"];
            for (NSString * title in model.titleOthersCn) {
                [otherTitles  appendString:title];
                [otherTitles appendString:@" "];
            }
            self.moreInfoLabel.text = otherTitles;
        }
        
        if (model.locationName) {
            self.tpeLabel.text = [NSString stringWithFormat:@"\n%@",model.locationName];
            if (model.movieType) {
                self.tpeLabel.text= [NSString stringWithFormat:@"%@\n%@",model.movieType,model.locationName];
            }
        }
        
        //如果是人物
    }else {
        self.titleLabel.text  = model.name;
        self.titleEn.text  = model.nameEn;
        if (model.profession) {
            self.moreInfoLabel.text = model.profession;
        }
        if (model.personMovies) {
            NSMutableString * movieNames = [NSMutableString stringWithFormat: @"好评作品:"];
            for (NSDictionary * movieDict in model.personMovies) {
                [movieNames appendString:movieDict[@"title"]];
                [movieNames appendString:@" "];

            }
            self.tpeLabel.text = movieNames;
        }
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
