//
//  TopListdDetailViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "TopListdDetailViewController.h"
#import "TopListDetailCell.h"
#import "TopListModel.h"
#import "AFNetworking.h"
#import "LZXHelper.h"
#define kTopListUrl @"http://api.m.mtime.cn/TopList/TopListDetails.api?pageIndex=%d&topListId=%d"
#define kTopListDetailCell @"TopListDetailCell"
#define  kScreenSize [UIScreen mainScreen].bounds.size
//标志字符串
#define kMovieTag @"movie"
#define kPersonTag @"person"
@interface TopListdDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    //TopListHeaderView * _HeaderView;
    TopListModel * _listModel;
}
@property(nonatomic)UITableView * tableView;
@property(nonatomic)NSMutableArray * dataArr;
@end

@implementation TopListdDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr=[[NSMutableArray alloc] init ];
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    //_HeaderView=[[TopListHeaderView alloc] init];s
    self.currentPage =1;
    [self initUI];
    [self firstDownload];
    [self createRefreshView];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height+40) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight=177;
    //self.tableView.tableHeaderView=_HeaderView;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:kTopListDetailCell bundle:nil] forCellReuseIdentifier:kTopListDetailCell];
}
- (void)firstDownload{
    _currentPage=1;
    NSString * str=[NSString stringWithFormat:kTopListUrl,_currentPage,self.boradId];
    [self detailDownloadWithUrlStr:str];

}
-(void)detailDownloadWithUrlStr:(NSString *)url{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.isRefreshing&&self.dataArr) {
            [self.dataArr removeAllObjects];
        }
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * listDict=dict[@"topList"];
        _listModel=[[TopListModel alloc] init];
        _listModel.name=listDict[@"name"];
        _listModel.summary=listDict[@"summary"];
        if (dict[@"movies"]) {
        NSArray * arr=dict[@"movies"];
        for (NSDictionary * moveDic in arr) {
            TopMoveModel * moveModel=[[TopMoveModel alloc] init];
            [moveModel setValuesForKeysWithDictionary:moveDic];
            [self.dataArr addObject:moveModel];
        }
            [self.dataArr addObject:kMovieTag];
        }
        if (dict[@"persons"]) {
            NSArray * arr=dict[@"persons"];
            for (NSDictionary * moveDic in arr) {
                TopPersonModel * moveModel=[[TopPersonModel alloc] init];
                [moveModel setValuesForKeysWithDictionary:moveDic];
                [self.dataArr addObject:moveModel];
            }
            [self.dataArr addObject:kPersonTag];
        }
        [SVProgressHUD dismiss];
        [self endRefreshing];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

//创建下拉刷新和上拉加载
-(void)createRefreshView{
    
    __weak typeof (self) weakSelf = self;//弱引用
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        //重新下载数据
        
        weakSelf.isRefreshing = YES;//标记正在刷新
        
        
        [weakSelf firstDownload];
        
        
        
    }];
    
    
    
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        
        weakSelf.currentPage ++;
        //判断类型处理下载数据
        NSString * str=[NSString stringWithFormat:kTopListUrl,weakSelf.currentPage,weakSelf.boradId];
        [weakSelf detailDownloadWithUrlStr:str];
        
        
    }];
}

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

#pragma mark - )<UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count-1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopListDetailCell * cell=[tableView dequeueReusableCellWithIdentifier:kTopListDetailCell forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    NSString * myTag = [self.dataArr lastObject];
    if ([myTag isEqualToString:kMovieTag]) {
        TopMoveModel * model=self.dataArr[indexPath.row];
        [cell showDataWithModel:model withIndexPath:indexPath];
    }else if ([myTag isEqualToString:kPersonTag]){
        TopPersonModel * model = self.dataArr[indexPath.row];
        [cell showDataWithPersonModel:model withIndexPath:indexPath];
    }

    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView=[[UIView alloc] init];
    UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenSize.width-10, 20)];
    label.text=_listModel.name;
    [headerView addSubview:label];
    UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(5, label.frame.origin.y+20, kScreenSize.width-10, [LZXHelper textHeightFromTextString:_listModel.summary width:kScreenSize.width-10 fontSize:13])];
    label1.font=[UIFont systemFontOfSize:13];
    label1.numberOfLines=0;
    label1.text=_listModel.summary;
    [headerView addSubview:label1];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25+[LZXHelper textHeightFromTextString:_listModel.summary width:kScreenSize.width-10 fontSize:15];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
