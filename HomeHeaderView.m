//
//  HomeHeaderCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomeHeaderView.h"
#import "JPControl.h"

#define kPadding kScreenSize.width*0.0625
#define kCellSize CGSizeMake(kScreenSize.width*0.4375+kScreenSize.width*0.0625,kScreenSize.width*0.625)
@implementation HomeHeaderView




- (void)initHeaderCell{
    self.backgroundColor = [UIColor whiteColor];
    if (self.myImageView==nil) {

    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHomeImageViewHeight)];
        UIImageView * imageView=  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kHomeImageViewHeight)];
        imageView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        [self.myImageView addSubview:imageView];
        
        [self addSubview:self.myImageView];
    }
    if (self.myScrollView==nil) {
        self.myScrollView = [[OTPageView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kImageSize.height)];
        
        self.myScrollView.pageScrollView.dataSource = self;
        self.myScrollView.pageScrollView.delegate = self;
        self.myScrollView.pageScrollView.padding =0;
        self.myScrollView.pageScrollView.leftRightOffset = 0;
        self.myScrollView.pageScrollView.pageViewWith = (kImageSize.width+kPadding);

        //pageScrollView
        self.myScrollView.pageScrollView.frame = CGRectMake((kScreenSize.width -kCellSize.width)/2, 0, kCellSize.width, kCellSize.height);
        self.myScrollView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.myScrollView];
    }
    if (self.myLabel==nil) {
        self.myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myScrollView.frame), kScreenSize.width, 30)];
        [self addSubview:self.myLabel];
    }
    if (self.titleLabel==nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.myScrollView.frame), kScreenSize.width-60, 30)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.shadowColor = [UIColor grayColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font=  [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
        [self addSubview:self.titleLabel];
        
    }
    if (self.ratingLabel) {
        self.ratingLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMaxY(self.myScrollView.frame), 30, 30)];
        self.ratingLabel.backgroundColor = [UIColor greenColor];
        [self.myLabel addSubview:self.ratingLabel];
    }
    if (self.buttonLabel==nil) {
        self.buttonLabel = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myImageView.frame),kScreenSize.width ,50)];
        [self addSubview:self.buttonLabel];
    }
    
    if (self.buyButton==nil) {
        self.buyButton = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/3.0, CGRectGetMaxY(self.titleLabel.frame), kScreenSize.width/3.0, 30) borderColor:nil borderWidth:0 titleColor:[UIColor whiteColor] adjustWidth:0 textAligment:NSTextAlignmentCenter target:self action:@selector(buyBtnClick:) ];
        self.buyButton.backgroundColor = [UIColor orangeColor];
        [self.buyButton setTitle:@"选座购票" forState:UIControlStateNormal];
        self.buyButton.titleLabel.font =[UIFont systemFontOfSize:15.0];
        self.buyButton.layer.cornerRadius = 10;
        [self addSubview:self.buyButton];
    }
    
    
    
    if (self.specialLabel==nil) {
        self.specialLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buyButton.frame), kScreenSize.width, 30)];
        self.specialLabel.textAlignment = NSTextAlignmentCenter;
        self.specialLabel.textColor = [UIColor orangeColor];
        self.titleLabel.shadowColor = [UIColor whiteColor];
        self.specialLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:self.specialLabel];
    }
    
    
    
    if (self.button1==nil) {
        
        
        self.button1 = [JPControl createButtonWithFrame:CGRectMake(0, 0, kScreenSize.width/3, 50) borderColor:[UIColor grayColor] borderWidth:0.3f titleColor:[UIColor blackColor] adjustWidth:YES textAligment:NSTextAlignmentCenter  target:self action:@selector(btn1Click:)];

        [self.buttonLabel addSubview:self.button1];
    }
    if (self.button2==nil) {
        
        self.button2 = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/3, 0, kScreenSize.width/3, 50) borderColor:[UIColor grayColor] borderWidth:0.3f titleColor:[UIColor blackColor] adjustWidth:YES textAligment:NSTextAlignmentCenter target:self action:@selector(btn1Click:)];


        [self.buttonLabel addSubview:self.button2];
    }
    if (self.button3==nil) {
        
        self.button3 = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/3*2, 0, kScreenSize.width/3, 50) borderColor:[UIColor grayColor] borderWidth:0.3f titleColor:[UIColor blackColor] adjustWidth:0.3f textAligment:NSTextAlignmentCenter target:self action:@selector(btn1Click:)];

        [self.buttonLabel addSubview:self.button3];
    }
    

    
}


- (void)showHomeHeaderCellDataWithHeaderModel:(HomeHeaderModel *)headerModel{
    
    self.headerModel = headerModel;
    [self initHeaderCell];
    self.imageViewArr = [[NSMutableArray alloc]init];

    for (int i = 0; i < headerModel.movies.count; i++) {
            HomeHeaderMovieModel * movieModel = [[HomeHeaderMovieModel alloc]init];
            [movieModel setValuesForKeysWithDictionary:  headerModel.movies[i]];


        UIImageView * imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(kPadding, 0, kImageSize.width, kImageSize.height)];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        imageView.clipsToBounds = YES;

        [imageView sd_setImageWithURL:[NSURL URLWithString:movieModel.img] placeholderImage:[UIImage imageNamed:@"empty"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //图片为空，且取第一个model时 刚进入界面的背景图片
            if (self.myImageView.image==nil&&i==0) {
                [self showSubViewWithModel:movieModel];
                
            }
            
        }];

        [self.imageViewArr addObject:imageView];

        
    }
//    if (self.myImageView==nil) {
//        //刚进入界面的背景图片
//        HomeHeaderMovieModel * movieModel1 = [[HomeHeaderMovieModel alloc]init];
//        [movieModel1 setValuesForKeysWithDictionary:self.headerModel.movies[0]];
//        [self showSubViewWithModel:movieModel1];
//        
//    }

    [self.button1 setTitle:[NSString stringWithFormat: @"%d\n%@",headerModel.totalHotMovie,@"正在热映"] forState:UIControlStateNormal];
    [self.button2 setTitle:[NSString stringWithFormat: @"%d\n%@",headerModel.totalComingMovie,@"即将上映"] forState:UIControlStateNormal];
    [self.button3 setTitle:[NSString stringWithFormat: @"%d\n%@",headerModel.totalCinemaCount,@"找影院"] forState:UIControlStateNormal];


    [self.myScrollView.pageScrollView reloadData];

    
}



#pragma mark - <OTPageScrollViewDataSource,OTPageScrollViewDelegate>/////

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return [self.imageViewArr count];
}
//滚动视图子视图的定制
- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCellSize.width, kCellSize.height)];
    
    UIImageView * imageView = [self.imageViewArr objectAtIndex:index];
    cell.clipsToBounds = YES;
    [cell addSubview:imageView];
    
    return cell;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return kCellSize;
}


//图片点击事件
- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    HomeHeaderMovieModel * movieModel = [[HomeHeaderMovieModel alloc]init];
    [movieModel setValuesForKeysWithDictionary:  self.headerModel.movies[index]];
    
    [self showSubViewWithModel:movieModel];
    


    if (self.myScrollView.pageScrollView.contentOffset.x == index*(kCellSize.width)) {
                BBLog(@"click cell at %ld",index);
        MyMovieDetailController * mVC = [[MyMovieDetailController alloc]init];
        mVC.locationId =self.locationId;
        mVC.movieId = self.movieId;
        mVC.movieTitle = self.movieTitle;
        [self.nivController pushViewController:mVC animated:YES];
    
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;

    HomeHeaderMovieModel * movieModel = [[HomeHeaderMovieModel alloc]init];
    [movieModel setValuesForKeysWithDictionary:  self.headerModel.movies[index]];
    
    [self showSubViewWithModel:movieModel];
    

}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    
//    HomeHeaderMovieModel * movieModel = [[HomeHeaderMovieModel alloc]init];
//    [movieModel setValuesForKeysWithDictionary:  self.headerModel.movies[index]];
//    
//    [self showSubViewWithModel:movieModel];
//
//}
//处理tableviewcell的子视图
- (void)showSubViewWithModel:(HomeHeaderMovieModel *)movieModel{
    self.titleLabel.text = [NSString stringWithFormat:@"%@  %.1f分" ,movieModel.titleCn,movieModel.ratingFinal];
    self.specialLabel.text = [NSString stringWithFormat:@"“%@”" ,movieModel.commonSpecial];
    
    [self processBlurImageWithModel:movieModel];
    self.movieId = movieModel.movieId;
    self.movieTitle = movieModel.titleCn;
    
}
//处理模糊图片，若不村子缓存，若存在直接读取
- (void)processBlurImageWithModel:(HomeHeaderMovieModel *)movieModel{
    
    //缓存模糊图片
    
    NSString *urlOfBlur = [NSString stringWithFormat:@"%@_Blur",movieModel.img];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:urlOfBlur];
    if (image) {
        self.myImageView.image = image;
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
    if (_imageView==nil) {
        _imageView = [[UIImageView alloc]init];
    }
#warning 修改了
    [weakSelf.myImageView sd_setImageWithURL:[NSURL URLWithString:movieModel.img] placeholderImage:[UIImage imageNamed:@"empty"] options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [weakSelf.myImageView setImageToBlur:image blurRadius:30 completionBlock:^(NSError *error) {
//            //将模糊后的图片缓存
//            [[SDImageCache sharedImageCache] storeImage:weakSelf.myImageView.image forKey:urlOfBlur];
//            BBLog(@"模糊化 ");
//        }];
    }];
    
}

- (void)btn1Click:(UIButton *)button
{


    [self.tabController setSelectedIndex:1];
}

- (void)setMyBuyHotBlock:(MyJumpBuyTicketBlock)myBlock{
    if (_myBuyBlock!= myBlock) {
        _myBuyBlock = [myBlock copy];
    }
}

- (void)setMyClickMovieBlock:(MyClickMovieBlock)myBlock{
    if (_myMovieBlock!=myBlock) {
        _myMovieBlock = [myBlock copy];
    }
    
    
}

- (void)buyBtnClick:(UIButton *)button
{

    BuyMovieDetailController * bVC = [[BuyMovieDetailController alloc]init];
    bVC.locationId =self.locationId;
    bVC.movieId = self.movieId;
    bVC.movieName = self.movieTitle;
    [self.nivController pushViewController:bVC animated:YES];
    
    
}

@end
