//
//  LocationViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@end

@implementation LocationViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = myRed;
    self.title = @"选择城市";
    
//设置返回button
    UIBarButtonItem * locationBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(popParent)];
    [locationBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = locationBtn;
    
    [self initUI];
    [self initData];

}




- (void)initUI{
    
    self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    

    
    
    self.currentLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 30)];
    self.currentLabel.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.currentLabel;
    
    
    
}

- (void)initData{
    self.currentLabel.text = @"   当前城市   正在定位...";
    __weak typeof(self) weakSelf = self;
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D coordinate) {
        NSString * locationUrl = [NSString stringWithFormat:kLocationUrl,coordinate.latitude,coordinate.longitude];
        //解决https出现的错误
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy = securityPolicy;
        [_manager GET:locationUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                weakSelf.locationModel = [[LocationModel alloc]init];
                [weakSelf.locationModel setValuesForKeysWithDictionary:dict];
                self.currentLabel.text = [NSString stringWithFormat:@"   当前城市   %@", weakSelf.locationModel.name ];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            BBLog(@"位置数据下载失败");
        }];
        
    }];
}



- (void)popParent{
    
    if (_myBlock) {
        //将地址model传过去
        _myBlock(self.locationModel);
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setMyBlock:(MyLocationBlock)myBlock{
    if (_myBlock != myBlock) {
        _myBlock = [myBlock copy];
    }
    
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
