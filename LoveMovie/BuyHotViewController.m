//
//  BuyHotViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyHotViewController.h"
#define kHotViewHeight self.view.frame.size.width
#define kBuyHotCellId @"BuyHotCell"
@interface BuyHotViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
    NSMutableArray * _dataArr ;
    
}
@end

@implementation BuyHotViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _manager = [AFHTTPRequestOperationManager manager];
    if (_dataArr==nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    [self initData];
    [self initUI];
    
}

- (void)initData{
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    if (_dataArr) {
        [_dataArr removeAllObjects];
    }
    NSString * url  = [NSString stringWithFormat:kBuyHotMovie,self.currentCityId];
    __weak typeof(self) weakSelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            BuyHotMovieModel * hotModel = [[BuyHotMovieModel alloc]init];
            [hotModel setValuesForKeysWithDictionary:dict];
            for (NSDictionary * msDict in hotModel.ms) {
                BuyMsModel * msModel = [[BuyMsModel alloc]init];
                [msModel setValuesForKeysWithDictionary:msDict];
                msModel.locationId = weakSelf.currentCityId;
                [_dataArr addObject:msModel];
            }
            
            [SVProgressHUD dismiss];
            [weakSelf.hotTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];

    
}

- (void)initUI{
    self.hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width,kScreenSize.height-99-49) style:UITableViewStylePlain];
    self.hotTableView.delegate =self;
    self.hotTableView.dataSource =self;
    [self.view addSubview:self.hotTableView];
    [self.hotTableView registerNib:[UINib nibWithNibName:@"BuyHotCell" bundle:nil] forCellReuseIdentifier:kBuyHotCellId];
}



#pragma mark - <UITableViewDataSource,UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyHotCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuyHotCell" forIndexPath:indexPath];
    
    BuyMsModel * msModel  = _dataArr[indexPath.row];
    //cell调用正在热映的push
    [cell setMyBlock:^(int movieId) {
        BuyMovieDetailController * bVC = [[BuyMovieDetailController alloc]init];
        bVC.movieId = movieId;
        bVC.movieName = msModel.tCn;
        bVC.myCoordinate = self.myCoordinate;
        bVC.locationId = self.currentCityId;
        [self.navigationController pushViewController:bVC animated:YES];
    }];
    
    [cell showDataWithMsModel:msModel];
    
    
    return cell;
}
//点击进入电影
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMovieDetailController * mVC = [[MyMovieDetailController alloc]init];
    BuyMsModel * msModel = _dataArr[indexPath.row];
    mVC.movieId = msModel.id;
    mVC.locationId = self.currentCityId;
    [self.navigationController pushViewController:mVC animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];



}



@end
