//
//  MallViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "MallViewController.h"

#define kMarketFirstCellId @"MarketFirstCell"
#define kFourCateCellId @"FourCateCell"
#define kSubViewCellId @"SubViewCell"
#define kMiddleHeroesCellId @"MiddleHeroesCell"
#define kCateDetailCellId @"CateDetailCell"
#define kRecommendCellId @"RecommendCell"
#define kRecommendCellId @"RecommendCell"



@interface MallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    AFHTTPRequestOperationManager * _manager;

    
}
@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    [self initUI];
//    [self initData];
}

- (void)initData{
    [_manager GET:kMarketUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.marketModel = [[MarketModel alloc]initWithDictionary:dict error:nil];
            
        }
        [self.myCollectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
}
- (void)initUI{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    

    self.myCollectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64) collectionViewLayout:flowLayout] ;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    [self.view addSubview:self.myCollectionView];
    
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MarketFirstCell" bundle:nil] forCellWithReuseIdentifier:kMarketFirstCellId];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"FourCateCell" bundle:nil] forCellWithReuseIdentifier:kFourCateCellId];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"SubViewCell" bundle:nil] forCellWithReuseIdentifier:kSubViewCellId];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MiddleHeroesCell" bundle:nil] forCellWithReuseIdentifier:kMiddleHeroesCellId];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"CateDetailCell" bundle:nil] forCellWithReuseIdentifier:kCateDetailCellId];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:nil] forCellWithReuseIdentifier:kRecommendCellId];


    
}
#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return 9;
//    
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
