//
//  areaSecondCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import "HomeAreaSecondModel.h"
@interface areaSecondCell : UITableViewCell

@property (nonatomic) UINavigationController * nivController;


@property (weak, nonatomic) IBOutlet UIButton *allProductsButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthButton;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;

@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButtton;

- (void)showDataWithAreaSecondModel:(HomeAreaSecondModel *)areaSecondModel;

@end
