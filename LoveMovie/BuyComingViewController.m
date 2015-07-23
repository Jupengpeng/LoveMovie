//
//  BuyComingViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyComingViewController.h"
#define kComingMovCellId @"ComingMovCell"
#define kComingHeaderCellId @"ComingHeaderCell"

@interface BuyComingViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    AFHTTPRequestOperationManager * _manager;
    NSMutableArray * _dataArr ;
    NSMutableArray * _topDataArr;
    int _currentMounth;
}
@property (nonatomic,strong) UILabel * bottomLabel;

@end

@implementation BuyComingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (_dataArr==nil) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    if (_topDataArr==nil) {
        _topDataArr = [[NSMutableArray alloc]init];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    label.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:label];
    [self initData];
    [self initUI];
    
}

- (void)initData{
    NSString * url = [NSString stringWithFormat:kBuyComingMovie,kZZLid];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.comingModel = [[BuyComingModel alloc]init];
            [self.comingModel setValuesForKeysWithDictionary:dict];
            for (NSDictionary * dict in self.comingModel.attention) {
                ComingMovieModel *  topMovieModel = [[ComingMovieModel alloc]init];
                [topMovieModel setValuesForKeysWithDictionary:dict];
                [_topDataArr addObject:topMovieModel];
            }
            NSMutableArray * mounths = [[NSMutableArray alloc]init];
            for (NSDictionary * dict in self.comingModel.moviecomings) {
                ComingMovieModel * moviModel = [[ComingMovieModel alloc]init];
                [moviModel setValuesForKeysWithDictionary:dict];
                [mounths addObject:[NSNumber numberWithInt: moviModel.rMonth]];
            }
            for (NSNumber * number in mounths) {
                NSMutableArray * myArr = [[NSMutableArray alloc]init];
                for (NSDictionary * dict in self.comingModel.moviecomings) {
                    ComingMovieModel * moviModel = [[ComingMovieModel alloc]init];
                    [moviModel setValuesForKeysWithDictionary:dict];
                    //将月不一样的分别加到数组里面
                    if (moviModel.rMonth==number.intValue) {
                        [myArr addObject:moviModel];
                    }
                }
                [_dataArr addObject:myArr];

            }
 

            [self.tableView reloadData];
            [self.collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
    
}


- (void)initUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-99-49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ComingMovCell" bundle:nil] forCellReuseIdentifier:kComingMovCellId];
    
    [self createMyHeaderView];
}
//创建头视图
- (void)createMyHeaderView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 220)];


    UILabel * topLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 30)];
    topLabel.text = @"   最受关注";
    topLabel.font =[UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    [headerView addSubview:topLabel];
    
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(kScreenSize.width, 150);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0,0, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenSize.width, 150) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.collectionView];
    
    //小灰边
    UILabel * grayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kScreenSize.width, 10)];
    grayLabel.backgroundColor = myGray;
    [headerView addSubview:grayLabel];
    
    
    self.bottomLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(grayLabel.frame), kScreenSize.width, 30)];
    self.bottomLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    [headerView addSubview:self.bottomLabel];
    
    
    //注册collectioncell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ComingHeaderCell" bundle:nil] forCellWithReuseIdentifier:kComingHeaderCellId];

    self.tableView.tableHeaderView = headerView;

}

#pragma mark -<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //collcection刷新数据时给即将上映个数赋值
    self.bottomLabel.text = [NSString stringWithFormat:@"   即将上映(%d部)",(int)self.comingModel.moviecomings.count];

    return _topDataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenSize.width, 150);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ComingHeaderCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:kComingHeaderCellId forIndexPath:indexPath];
    ComingMovieModel * movieModel =  _topDataArr[indexPath.row];
    
    
    [cell showHeaderDataWithMovieModel:movieModel];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSArray * arr = _dataArr[section];
    ComingMovieModel * model = arr[0];
    return [NSString stringWithFormat:@"%02d月",model.rMonth];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = _dataArr[section];

    
    return arr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ComingMovCell * cell = [tableView dequeueReusableCellWithIdentifier:kComingMovCellId forIndexPath:indexPath];;
    NSArray * arr = _dataArr[indexPath.section];

    ComingMovieModel * movieModel = arr[indexPath.row];
    [cell showDataWithMovieModel:movieModel];

    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
