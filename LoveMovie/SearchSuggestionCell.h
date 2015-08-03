//
//  searchSuggestionCell.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchSuggestModel.h"
#import "UIImageView+WebCache.h"
@interface SearchSuggestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleAndTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameEnLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

- (void)showDataWithSuggeestModel:(SearchSuggestModel *)model;

@end
