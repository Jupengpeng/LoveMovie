//
//  FirstPageViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomePageViewController.h"
#import "AFNetworking.h"
#import "HomeHotPointModel.h"
#import "areaSecondCell.h"
#import "HomeAreaSecondModel.h"
#import "HomeHotPointCell.h"
#import "HomeHotType1Cell.h"
#import "HomeHotType2Cell.h"
#import "HomeHotPointType3.h"
#import "HomeHotPointModel.h"
#import "HomeHotMovieCell.h"
#import "HomeHotMovieModel.h"
#import "HomeMovieModel.h"
#import "HomeScrollCell.h"
#import "HomeAdvModel.h"
#import "HomeHeaderModel.h"
#import "HomeHeaderView.h"
#import "NewsDetailViewController.h"
#define kareaSecondCellId @"areaSecondCell"
#define kHotpointButtonCellId @"HomeHotPointCell"
#define kHomeHotType1CellId @"HomeHotType1Cell"
#define kHomeHotType2CellId @"HomeHotType2Cell"
#define kHomeHotPointType3Id @"HomeHotPointType3"
#define kHomeHotMovieCellId @"HomeHotMovieCell"
#define kHomeScrollCellId @"HomeScrollCell"
#define kHomeHeaderViewId @"HomeHeaderView"
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) HomePageModel * homePageModel;
@property (nonatomic,strong) HomeHeaderModel * headerModel;
@property (nonatomic,strong)CLLocationManager * locationManager;



@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    self.tabBarController.tabBar.tintColor = myRed;


    
    //左上角位置button
    
    NSString * locationName = @"位置";

    self.locationBtn = [[UIBarButtonItem alloc]initWithTitle:locationName style:UIBarButtonItemStyleBordered target:self action:@selector(locationClick:)];
    [self.locationBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = self.locationBtn;
    //二维码扫描
    UIBarButtonItem *scanBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_scan_barcode"] style:UIBarButtonItemStylePlain target:self action:@selector(scanClick:)];
    scanBtn.tintColor = [UIColor whiteColor];
    //右上角搜索
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"v10_search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick:)];
    searchBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[searchBtn,scanBtn];
    
    
    
    [self initUI];
    [self createHeaderRefreshView];
    //获取当前地址
    [self getCurrentLocation];
    
    

    
}

- (void)searchClick:(UIBarButtonItem * )item{
    
    HomePageSearchController * sVC = [[HomePageSearchController alloc]init];
    [self.navigationController pushViewController:sVC animated:YES];
    
}

- (void)scanClick:(UIBarButtonItem *)item{
    QRCodeScanController * qVC = [[QRCodeScanController alloc]init];
    [self.navigationController pushViewController:qVC animated:YES];
    
    
}


- (void)getCurrentLocation{
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    __weak typeof(self) weakSelf = self;
    

    
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D coordinate) {
        NSString * locationUrl = [NSString stringWithFormat:kLocationUrl,coordinate.latitude,coordinate.longitude];
        [_manager GET:locationUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                weakSelf.locationModel = [[LocationModel alloc]init];
                [weakSelf.locationModel setValuesForKeysWithDictionary:dict];
                weakSelf.locationBtn.title =weakSelf.locationModel.name;
                weakSelf.currentCityId =weakSelf.locationModel.cityId;
                
                
                [weakSelf initData];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            BBLog(@"%@",[error description]);
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"下载失败，请检查网络"];
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
            [weakSelf initData];
            [weakSelf.tableView reloadData];
            
        }else{
            weakSelf.locationBtn.title = weakSelf.locationBtn.title;
            weakSelf.currentCityId = weakSelf.currentCityId;

        }
        
    }];
    [weakSelf.navigationController pushViewController:lvc animated:YES];
    
    
    
}
//刷新功能 子类调用
- (void)createHeaderRefreshView{
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        [weakSelf getCurrentLocation];
    }];
    
}

- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }

}

- (void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenSize.width, kScreenSize.height+64)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"areaSecondCell" bundle:nil]   forCellReuseIdentifier:kareaSecondCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotPointCell" bundle:nil] forCellReuseIdentifier:kHotpointButtonCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotType1Cell" bundle:nil] forCellReuseIdentifier:kHomeHotType1CellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotType2Cell" bundle:nil] forCellReuseIdentifier:kHomeHotType2CellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotPointType3" bundle:nil] forCellReuseIdentifier:kHomeHotPointType3Id];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotMovieCell" bundle:nil] forCellReuseIdentifier:kHomeHotMovieCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeScrollCell" bundle:nil] forCellReuseIdentifier:kHomeScrollCellId];
    [self.tableView registerClass:[HomeHeaderView class] forCellReuseIdentifier:kHomeHeaderViewId];
    
}
- (void)initData{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    
    NSString * headerUrl = [NSString stringWithFormat:kHomeHeaderUrl,self.currentCityId];
    
    __weak typeof(self) weakSelf = self;
    [_manager GET:headerUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            weakSelf.headerModel = [[HomeHeaderModel alloc]init];
            [weakSelf.headerModel setValuesForKeysWithDictionary:dict];
            
        }
        
        [SVProgressHUD dismiss];
        
        [weakSelf.tableView reloadData];
        [weakSelf endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败%@",error );
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"下载失败，请检查网络"];

    }];
    
    
    [_manager GET:kHomePageUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            weakSelf.homePageModel = [[HomePageModel alloc]initWithDictionary:dict error:nil];
        }
        [weakSelf.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败%@",[error description]);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"下载失败，请检查网络"];
    }];
    
    

    
    
}

- (void)initLocation{
    __weak typeof(self) weakSelf = self;
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D coordinate) {
        
        
        NSString * locationUrl = [NSString stringWithFormat:kLocationUrl,coordinate.latitude,coordinate.longitude];
        [_manager GET:locationUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                weakSelf.locationModel = [[LocationModel alloc]init];
                [weakSelf.locationModel setValuesForKeysWithDictionary:dict];
                NSLog(@"走进base位置%@",weakSelf.locationModel.name);
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            BBLog(@"位置数据下载失败");
            
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"下载失败，请检查网络"];
            
        }];
        
    }];
    
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            return kHomeImageViewHeight+50;
        }
        case 1:
        {
            return 530;
        }
        case 2:
        {
            return 98;
        }
            //
        case 3:
        {
            return 49;
        }
            //两种cell根据type判断
        case 4:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[0];
            if (model.type==1) {
                return 160;
            }else{
                return 120;
            }
        }
        case 5:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[1];
            if (model.type==1) {
                return 160;
            }else{
                return 120;
            }
        }
            break;
        case 6:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[2];
            if (model.type==1) {
                return 160;
            }else{
                return 120;
            }
        }
            break;
        case 7:
        {
            return 49;
        }
            break;
        case 8:
        {
            return 315;
        }
            break;
            
        default:
            break;
    }
    return 530;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[[UITableViewCell alloc]init];
    switch (indexPath.row) {
        case 0:{
            HomeHeaderView * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHeaderViewId forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
            

            
            cell.locationId = self.currentCityId;
            cell.nivController = self.navigationController;
            cell.tabController = self.tabBarController;
            [cell showHomeHeaderCellDataWithHeaderModel:self.headerModel];
            return cell;
            
            
        }
        case 1:{
            areaSecondCell * cell  = [tableView dequeueReusableCellWithIdentifier:kareaSecondCellId forIndexPath:indexPath];
            HomeAreaSecondModel * areaSecondModel = self.homePageModel.areaSecond;
            [cell showDataWithAreaSecondModel:areaSecondModel];
            return cell;
        }
        case 2:{
            HomeScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeScrollCellId forIndexPath:indexPath];
            [cell showDataWithAdvModel:self.homePageModel];
            return cell;
        }
        case 3:{
            HomeHotPointCell * cell = [tableView dequeueReusableCellWithIdentifier:kHotpointButtonCellId forIndexPath:indexPath];
            
            return cell;
        }
        case 4:{
            //4 5 6 cell判断type来决定cell的类型
            HomeHotPointModel * model = self.homePageModel.hotPoints[0];
            if (model.type==1) {
                HomeHotType1Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                
                return cell;
                
            }else{
                HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                return cell;
                
            }
            
        }
        case 5:{
            HomeHotPointModel * model = self.homePageModel.hotPoints[1];
            if (model.type==1) {
                HomeHotType1Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                
                return cell;
                
            }else{
                HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                return cell;
                
            }        }
        case 6:{
            HomeHotPointModel * model = self.homePageModel.hotPoints[2];
            if (model.type==1) {
                HomeHotType1Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                
                
                return cell;
                
            }else{
                HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                return cell;
                
            }        }
        case 7:{
            HomeHotPointType3 * cell = [tableView  dequeueReusableCellWithIdentifier:kHomeHotPointType3Id forIndexPath:indexPath];
            cell.tabBarController = self.tabBarController;
            return cell;
        }
        case 8:{
            HomeHotMovieCell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotMovieCellId forIndexPath:indexPath];
            
            [cell setMyHotBlock:^(int Id) {
                BBLog(@"%d",Id);
            }];
            cell.nivController =self.navigationController;
            cell.tabController = self.tabBarController;
            [cell showDataWithHomeHotMovieModel:self.homePageModel.hotMovie];
            
            [cell setMyHotBlock:^(int Id) {
                MyMovieDetailController * mVC = [[MyMovieDetailController alloc]init];
                mVC.movieId = Id;
                [self.navigationController pushViewController:mVC animated:YES];
            }];
            return cell;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {

            
        case 3:
        {
            [self.tabBarController setSelectedIndex:2];
            break;
        }
            //两种cell根据type判断
        case 4:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[0];
            NewsDetailViewController * nVC = [[NewsDetailViewController alloc]init];
            nVC.newsId = model.id;
            [self.navigationController pushViewController:nVC animated:YES];
            break;
        }
        case 5:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[1];
            NewsDetailViewController * nVC = [[NewsDetailViewController alloc]init];

            nVC.newsId = model.id;
            [self.navigationController pushViewController:nVC animated:YES];
        }
            break;
        case 6:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[2];
            NewsDetailViewController * nVC = [[NewsDetailViewController alloc]init];

            nVC.newsId = model.id;
            [self.navigationController pushViewController:nVC animated:YES];
        }
            break;
        case 7:
        {

        }
            break;
        case 8:
        {

        
        
        }
            break;
            
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}







@end
