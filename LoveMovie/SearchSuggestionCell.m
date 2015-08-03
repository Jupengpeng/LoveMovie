//
//  searchSuggestionCell.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "SearchSuggestionCell.h"

@implementation SearchSuggestionCell

- (void)awakeFromNib {

    self.coverImageView.clipsToBounds = YES;
    [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
}


- (void)showDataWithSuggeestModel:(SearchSuggestModel *)model{
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]    placeholderImage:[UIImage imageNamed:@"empty"]];
    if (model.type==1) {
        self.titleAndTypeLabel.text = [NSString stringWithFormat:@"%@(%@)",model.titlecn,@"电影"];
        self.detailLabel.text=[NSString stringWithFormat:@"%@,%@,%@",model.movieType,model.contentType,model.locationName];

    }else{
        self.titleAndTypeLabel.text = [NSString stringWithFormat:@"%@(%@)",model.titlecn,@"影人"];
        self.detailLabel.text = [NSString stringWithFormat:@"%@,%@,%@,%@",model.sex,model.birth,model.rLocation,model.profession];
    }
    self.nameEnLabel.text = model.titleen;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
