//
//  BuyTicketViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyTicketViewController.h"
#import "JPControl.h"
#define kMovBtnTag 101
@interface BuyTicketViewController ()

@end

@implementation BuyTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    if (self.movieViewController==nil) {
        self.movieViewController = [[BuyMovieViewController alloc]init];
    }
    if (self.cinemaViewController==nil) {
        self.cinemaViewController = [[BuyCinemaViewController alloc]init];
    }
    
    
    UILabel * locationLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    locationLabel.text =@"郑州";
    UIBarButtonItem * locationBtn = [[UIBarButtonItem alloc]initWithTitle:@"郑州" style:UIBarButtonItemStyleBordered target:self action:@selector(locationClick:)];
    self.navigationItem.leftBarButtonItem = locationBtn;
    
    [self initUI];

    
}

- (void)locationClick:(UIBarButtonItem *)barButtonItem{
    [self beginLocation];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nslog) userInfo:nil repeats:NO];


}
- (void)nslog{
    NSLog(@"longitude:%f",self.coordinate.longitude);
    NSLog(@"latitude:%f",self.coordinate.latitude);
    
}

- (void)initUI{
    
    [self addChildViewController:self.movieViewController];
    [self.view addSubview:self.movieViewController.view];
    NSArray * titles = @[@"电影",@"影院"];
    if (self.segmentControl==nil) {
        self.segmentControl = [[UISegmentedControl alloc]initWithItems:titles];
        self.segmentControl.frame = CGRectMake(0, 0, kScreenSize.width/2.0, 30);
        self.segmentControl.layer.cornerRadius = 15;
        self.segmentControl.clipsToBounds = YES;
        self.segmentControl.layer.borderWidth = 1.0f;
        self.segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
        self.segmentControl.tintColor = [UIColor whiteColor];
        self.navigationItem.titleView= self.segmentControl;
        [self.segmentControl setSelectedSegmentIndex:0];
        [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    
    
}

- (void)segmentControlAction:(UISegmentedControl *)segmentControl{
    //两个子视图一个移去一个加上
    if (segmentControl.selectedSegmentIndex==0) {
        if (self.cinemaViewController) {
            [self.cinemaViewController removeFromParentViewController];
            [self.cinemaViewController.view removeFromSuperview];
        }
        
        
        [self addChildViewController:self.movieViewController];
        [self.view addSubview:self.movieViewController.view];  
    }
    else{
        if (self.movieViewController) {
            [self.movieViewController removeFromParentViewController];
            [self.movieViewController.view removeFromSuperview];
            [self addChildViewController:self.cinemaViewController];
            [self.view addSubview:self.cinemaViewController.view];
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
