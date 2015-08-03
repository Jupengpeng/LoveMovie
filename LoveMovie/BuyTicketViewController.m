//
//  BuyTicketViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyTicketViewController.h"
#import "JPControl.h"
@interface BuyTicketViewController ()
{
    AFHTTPRequestOperationManager * _manager;
}
@end

@implementation BuyTicketViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets= NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (self.movieViewController==nil) {
        self.movieViewController = [[BuyMovieViewController alloc]init];
    }
    if (self.cinemaViewController==nil) {
        self.cinemaViewController = [[BuyCinemaViewController alloc]init];
    }
    
    
    //左上角位置button
    
    NSString * locationName = @"位置";
    self.locationBtn = [[UIBarButtonItem alloc]initWithTitle:locationName style:UIBarButtonItemStyleBordered target:self action:@selector(locationClick:)];
    [self.locationBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = self.locationBtn;
    //获取当前地址
    [self getCurrentLocation];
    
    
    
}

- (void)getCurrentLocation{
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    
    __weak typeof(self) weakSelf = self;
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D coordinate) {
        NSString * locationUrl = [NSString stringWithFormat:kLocationUrl,coordinate.latitude,coordinate.longitude];
        weakSelf.cinemaViewController.myCoordinate = coordinate;
        weakSelf.movieViewController.myCoordinate = coordinate;
        [_manager GET:locationUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                weakSelf.locationModel = [[LocationModel alloc]init];
                [weakSelf.locationModel setValuesForKeysWithDictionary:dict];
                weakSelf.locationBtn.title =weakSelf.locationModel.name;
                weakSelf.currentCityId =weakSelf.locationModel.cityId;
                weakSelf.cinemaViewController.currentCityId = weakSelf.locationModel.cityId;
                weakSelf.movieViewController.currentCityId =weakSelf.locationModel.cityId;
                
                
                [self initUI];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            BBLog(@"位置数据下载失败");
        }];
        
    }];
    
}

- (void)locationClick:(UIBarButtonItem *)barButtonItem
{
    LocationViewController * lvc = [[LocationViewController alloc]init];
    __weak typeof(self) weakSelf=  self;
    
    [lvc setMyBlock:^(LocationModel *locationModel) {
        
        if (locationModel.name) {
            
            weakSelf.locationBtn.title = locationModel.name;
            //城市id的传递 持续向下传递
            weakSelf.currentCityId = locationModel.cityId;
            
            weakSelf.cinemaViewController.currentCityId = locationModel.cityId;
            weakSelf.movieViewController.currentCityId = locationModel.cityId;
            
        
            [self initUI];
        }else{
            weakSelf.locationBtn.title = weakSelf.locationBtn.title;
            weakSelf.currentCityId = weakSelf.currentCityId;
            
        }
    }];
    [self.navigationController pushViewController:lvc animated:YES];
    
    
    
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
        [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    [self.segmentControl setSelectedSegmentIndex:0];

    
    
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
