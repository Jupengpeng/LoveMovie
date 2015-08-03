//
//  FindViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//


#import "FindViewController.h"
#define kHomeHotType1CellId @"HomeHotType1Cell"
#define kHomeHotType2CellId @"HomeHotType2Cell"
#define kListCellId @"cellId"
#define kReviewCellId @"MyReviewCell"
@interface FindViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation FindViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (self.dataArr== nil) {
        self.dataArr = [[NSMutableArray alloc]init];
    }
    _currentPage =1;
    [self initUI];
//    [self createHeaderRefreshView];;
    [self initHeaderData];
    [self firstDownload];
}

- (void)firstDownload{

    

    
    _currentPage=1;
    //判断类型处理第一次下载数据
    if ([self.type isEqualToString:kNewType]) {
        NSString * url = [NSString stringWithFormat:kFindNewsUrl,_currentPage];
        [self downLoadDataWitUrl:url];
        
    }else if ([self.type isEqualToString:kForeType]){
        [self downLoadDataWitUrl:kForeDisplayUrl];
    
    }else if ([self.type isEqualToString:kSortType]){
        NSString * url = [NSString stringWithFormat:kSortBoardUrl,_currentPage];
        [self downLoadDataWitUrl:url];

    }else{

        [self downLoadDataWitUrl:kFindCommentUrl];
    }
    
    
}

- (void)downLoadDataWitUrl:(NSString *)url{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    
    __weak typeof(self) weakSelf =self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (weakSelf.dataArr&&weakSelf.isRefreshing) {
            [weakSelf.dataArr removeAllObjects];
        }
        if (responseObject) {
            //判断类型下载任务
            if ([weakSelf.type isEqualToString:kNewType]) {
                
                NSDictionary *dict=  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray * newsListArr = [NSArray arrayWithArray:dict[@"newsList"]];
                for (NSDictionary * dict in newsListArr) {
                    NewsListModel * model = [[NewsListModel alloc]init];;
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.dataArr addObject:model];
                }
            }else if ([self.type isEqualToString:kForeType]){
                
                NSDictionary *dict=  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray * trailers  = [NSArray arrayWithArray:dict[@"trailers"]];
                for (NSDictionary * dict in trailers) {
                    ForeDisPlayModel * model = [[ForeDisPlayModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.dataArr addObject:model];
                }
            }else if ([weakSelf.type isEqualToString:kSortType]){
                
                NSDictionary *dict=  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSArray * topLosts = [NSArray arrayWithArray:dict[@"topLists"]];
                for (NSDictionary * dict in topLosts) {
                    SortBoardModel * model = [[SortBoardModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.dataArr addObject:model];
                }
                
            }else{
                
                NSArray * array=  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                for (NSDictionary * dict in array) {
                    ReviewModel * model =  [[ReviewModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [weakSelf.dataArr addObject:model];
                }
            
            }
            
        }
        [SVProgressHUD dismiss];
        [weakSelf endRefreshing];
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
}

- (void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-64-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    [self.view addSubview:self.tableView];
    
    
   self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.width*0.5f+90)];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.width*0.5f)];
    self.imageView.clipsToBounds = YES;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.headerView addSubview:self.imageView];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), kScreenSize.width, 40)];
    self.titleLabel.backgroundColor  = [UIColor blackColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font  = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.titleLabel];
    
    UIButton * topListButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), kScreenSize.width, 50)];
    topListButton.layer.borderColor = myLight.CGColor;
    topListButton.layer.borderWidth = 1.0f;
    UIImageView * imageView1 =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    imageView1.image = [UIImage imageNamed:@"v10_ChineseTop100"];
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenSize.width-40, 10,30 , 30)];
    imageView2.image = [UIImage imageNamed:@"v10_GlobalTopList"];
    [topListButton addSubview:imageView1];
    [topListButton addSubview:imageView2];
    [topListButton setTitle:@"全球票房榜" forState:UIControlStateNormal];
    [topListButton setTitleColor:myRed forState:UIControlStateNormal];
    [topListButton addTarget:self action:@selector(topListClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:topListButton];
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:kHomeHotType1CellId bundle:nil] forCellReuseIdentifier:kHomeHotType1CellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotType2Cell" bundle:nil] forCellReuseIdentifier:kHomeHotType2CellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReviewCell" bundle:nil] forCellReuseIdentifier:kReviewCellId];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kListCellId];
    
}
//跳转到排行榜界面
- (void)topListClick:(UIButton *)button{
    
    
}

- (void)initHeaderData{
    [_manager GET:kFindTopUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            self.newsHeaderModel = [[NewsHeaderModel alloc]init];
            self.trailerHeaderModel = [[TrailerHeaderModel alloc]init];
            self.topListHeaderModel = [[TopListHeaderModel alloc]init];
            self.reviewHeaderModel = [[ReviewHeaderModel alloc]init];
            [self.newsHeaderModel setValuesForKeysWithDictionary:dict[@"news"]];
            [self.trailerHeaderModel setValuesForKeysWithDictionary:dict[@"trailer"]];
            [self.topListHeaderModel setValuesForKeysWithDictionary:dict[@"topList"]];
            [self.reviewHeaderModel setValuesForKeysWithDictionary:dict[@"review"]];
            
            [self showHeaderView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];


}

- (void)showHeaderView{
    //判断类型处理头视图
    if ([self.type isEqualToString:kNewType]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.newsHeaderModel.imageUrl] placeholderImage:[UIImage imageNamed:@"emoty"]];
        self.titleLabel.text = self.newsHeaderModel.title;
    }else if ([self.type isEqualToString:kForeType]){
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.trailerHeaderModel.imageUrl] placeholderImage:[UIImage imageNamed:@"emoty"]];
        self.titleLabel.text = self.trailerHeaderModel.title;
    }else if ([self.type isEqualToString:kSortType]){
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topListHeaderModel.imageUrl] placeholderImage:[UIImage imageNamed:@"emoty"]];
        self.titleLabel.text = self.topListHeaderModel.title;
    }else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.reviewHeaderModel.imageUrl] placeholderImage:[UIImage imageNamed:@"emoty"]];
        self.titleLabel.text = self.reviewHeaderModel.title;
    }
    
    
}

//创建下拉刷新和上拉加载
-(void)createHeaderRefreshView{
    
    __weak typeof (self) weakSelf = self;//弱引用
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        //重新下载数据
        
        weakSelf.isRefreshing = YES;//标记正在刷新

        
        [weakSelf firstDownload];
        

        
    }];
}

- (void)createFooterRefresh{
    __weak typeof (self) weakSelf = self;//弱引用


    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        
       weakSelf.currentPage ++;
        //判断类型处理下载数据
        if ([weakSelf.type isEqualToString:kNewType]) {
            NSString * url = [NSString stringWithFormat:kFindNewsUrl,weakSelf.currentPage];
            [weakSelf downLoadDataWitUrl:url];
            
        }else if ([weakSelf.type isEqualToString:kSortType]){
            NSString * url = [NSString stringWithFormat:kSortBoardUrl,weakSelf.currentPage];
            [weakSelf downLoadDataWitUrl:url];
            
        }

        
    }];
    
    
}
//结束刷新
- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断类型处理第一次下载数据
    if ([self.type isEqualToString:kNewType]) {
        NewsListModel * model = self.dataArr[indexPath.row];
        if (model.type==0||model.type==2) {
            return 120;
            
        }else{
            return 160;
        }
        
    }else if ([self.type isEqualToString:kForeType]){
        
        return 120;
    }else if ([self.type isEqualToString:kSortType]){
        

        SortBoardModel * model = self.dataArr[indexPath.row];
        CGFloat cellHeight = [LZXHelper textHeightFromTextString:model.topListNameCn width:kScreenSize.width-20 fontSize:16.0f];
        
        
        return cellHeight+30;
    }else{
        
        return 150;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [[UITableViewCell alloc]init];
    //判断类型处理第一次下载数据
    if ([self.type isEqualToString:kNewType])
    {
        NewsListModel * model = self.dataArr[indexPath.row];
        if (model.type==0||model.type==2) {
            HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
            [cell showDataWithNewsListModel:model];
            return cell;

            
        } else {
            HomeHotType1Cell * cell  = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
            [cell showDataWithNewsListModel:model];
            return cell;

            
        }
    } else if ([self.type isEqualToString:kForeType]){
        HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
        ForeDisPlayModel * model = self.dataArr[indexPath.row];
        [cell showDataWithForeDisPlayModel:model];
        return cell;

    } else if ([self.type isEqualToString:kSortType]){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kListCellId forIndexPath:indexPath];
        SortBoardModel * model = self.dataArr[indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = model.topListNameCn;
        return cell;
    } else {
        ReviewCell * cell = [tableView dequeueReusableCellWithIdentifier:kReviewCellId forIndexPath:indexPath];
        ReviewModel * model = self.dataArr[indexPath.row];
        [cell showDataWithReviewModel:model];
        return cell;
    }
    
    BBLog(@"无cell");
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断类型处理点击事件
    if ([self.type isEqualToString:kNewType]) {
        NewsDetailViewController * dVC = [[NewsDetailViewController alloc]init];
        NewsListModel * model = self.dataArr[indexPath.row];
        dVC.newsId = model.id;
        [self.navigationController pushViewController:dVC animated:YES];
        
    }else if ([self.type isEqualToString:kForeType]){
        ForeDisPlayModel * model = self.dataArr[indexPath.row];
        ForedisplayDetailController * fVC = [[ForedisplayDetailController alloc]init];
        fVC.mp4Url = model.url;
        fVC.myTitle = model.movieName;
        fVC.summary = model.summary;
        [self.navigationController pushViewController:fVC animated:YES];
    
    }else if ([self.type isEqualToString:kSortType]){
        SortBoardModel * model =self.dataArr[indexPath.row];
        TopListdDetailViewController * tVC = [[TopListdDetailViewController alloc]init];
        tVC.boradId = model.id;
        [self.navigationController pushViewController:tVC animated:YES];
    
    }else{
        ReviewModel * model = self.dataArr[indexPath.row];
        ReviewDetailViewController * rVC = [[ReviewDetailViewController alloc]init];
        rVC.reviewId = model.id;
        [self.navigationController pushViewController:rVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}



@end
