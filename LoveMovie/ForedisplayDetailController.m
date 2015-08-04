//
//  ForedisplayDetailController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "ForedisplayDetailController.h"
#import "KrVideoPlayerController.h"
@interface ForedisplayDetailController ()
{
    CGRect _frame;
}
@property (nonatomic, strong) KrVideoPlayerController  *videoController;


@end

@implementation ForedisplayDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    NSURL *url = [NSURL URLWithString:self.mp4Url];
    
    [self initUI];
    [self addVideoPlayerWithURL:url];
    
    
    
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 74, kScreenSize.width-20, kScreenSize.width/10)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.adjustsFontSizeToFitWidth= YES;
    titleLabel.text = self.myTitle;
    [self.view addSubview:titleLabel];
    
    UILabel * sumarylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+10, kScreenSize.width-20, kScreenSize.width/10)];
    sumarylabel.textAlignment = NSTextAlignmentCenter;
    sumarylabel.font = [UIFont systemFontOfSize:17];
    sumarylabel.text = self.summary;
    [self.view addSubview:sumarylabel];

    _frame = sumarylabel.frame;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.videoController dismiss];
    
}
- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        CGFloat width = kScreenSize.width;
        CGFloat height =width*(9.0/16.0);
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_frame)+30, width,height )];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}
//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.tintColor = myRed;
    self.navigationController.navigationBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
