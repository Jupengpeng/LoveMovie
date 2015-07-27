//
//  ComingMovCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "ComingMovCell.h"

@implementation ComingMovCell

- (void)awakeFromNib {
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)ticketBtnClick:(id)sender {
    
    
}
- (IBAction)videoBtnClick:(id)sender {
    
    
    
}

- (void)showDataWithMovieModel:(ComingMovieModel *)movieModel{
    [self processButton:self.beOnButton];
    if (movieModel.videos.count) {
        self.foreshowButton.hidden=NO;
        [self processButton:self.foreshowButton];
        
        [self.foreshowButton setTitleColor:myPink forState:UIControlStateNormal];
        self.foreshowButton.backgroundColor = [UIColor whiteColor];
        [self.foreshowButton setTitle:@"预告片" forState:UIControlStateNormal];
    }else{
        self.foreshowButton.hidden = YES;
    }

    if (movieModel.isTicket) {
        [self.beOnButton setTitle:@"超前预售" forState:UIControlStateNormal];
        [self.beOnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.beOnButton.backgroundColor = myPink;
    }else{
        [self.beOnButton setTitle:@"敬请期待" forState:UIControlStateNormal];
        [self.beOnButton setTitleColor:myPink forState:UIControlStateNormal];
        self.beOnButton.enabled = YES;
        self.beOnButton.backgroundColor = [UIColor whiteColor];
    }
    
    self.dateLabel.text = [NSString stringWithFormat:@"%d日" ,movieModel.rDay];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = movieModel.title;

    //为观看人数显示部分添加富文本
    NSString * wantedNum = [NSString stringWithFormat:@"%d",movieModel.wantedCount];
    NSString * wantedText = [NSString stringWithFormat:@"%@人想看 - %@",wantedNum,movieModel.type];
    
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:wantedText];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, wantedNum.length) ];
    self.wantedLabel.attributedText = attributeStr;
    
    

    self.directorLabel.text = [NSString stringWithFormat:@"导演：%@",movieModel.director];
    if (movieModel.actor1.length) {
        self.actorLabel.text = [NSString stringWithFormat:@"演员：%@、%@",movieModel.actor1,movieModel.actor2];
    }else{
        self.actorLabel.text=  @"";
    }
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: movieModel.image ]placeholderImage:[UIImage imageNamed:@"empty"]];
    self.coverImageView.clipsToBounds = YES;
    [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
   
    //使用block回传 几月
    if (_myBlock) {
        _myBlock(movieModel.rMonth);
    }
}
- (void)setMyBlock:(MounthBlock)myBlock{
    if (_myBlock != myBlock) {
        _myBlock = [myBlock copy];
    }
    
}

//设置按钮边框登等
- (void)processButton:(UIButton*)button{
    button.layer.borderColor = myPink.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius  = 12;
}
@end
