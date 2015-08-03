//
//  HomePageSearchController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomePageSearchController.h"

@interface HomePageSearchController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    
    
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchController;
        // NSMutableArray *self.dataArray;
    NSMutableArray *_filteredArray; // 存放搜索结果，这个结果刷新到searchController自带的tableView上
    
    
    NSMutableArray * _dataArr;
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic) NSMutableArray * dataArr;
@property (nonatomic) NSMutableArray * hotArr;

@end

@implementation HomePageSearchController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    _filteredArray = [[NSMutableArray alloc] init];

    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;

    
    [self initUI];
    
    [self initHotData];
}

- (void)initUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle =UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:self.tableView];
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
    _searchBar.placeholder = @"搜索电影/影人";
    
    self.tableView.tableHeaderView = _searchBar;

    _searchController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchBar.delegate = self;
    _searchController.searchResultsDelegate =self;
    _searchController.searchResultsDataSource =self;
    _searchController.delegate = self;
    
    
    

    [_searchController.searchResultsTableView registerNib:[UINib nibWithNibName:@"SearchSuggestionCell" bundle:nil] forCellReuseIdentifier:@"SearchSuggestionCell"];
}



//第一次下载
- (void)initHotData{
    _hotArr = [[NSMutableArray alloc]init];
    [_manager GET:kSearchHotUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [_hotArr addObjectsFromArray:dict[@"keywords"]];
            [_hotArr removeObject:@""];
            
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    

    
    
}


- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView==self.tableView) {
        return @"热门搜索";
    }
    
    return [NSString stringWithFormat:@"正在搜索%@",_searchBar.text];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.tableView) {
        return _hotArr.count;
    }
    return self.dataArr.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
                return 40;
            }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        static NSString * cellId = @"cellId" ;
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text= _hotArr[indexPath.row];
        return cell;
        
    }else{
    

    
    
    SearchSuggestionCell * cell = [_searchController.searchResultsTableView dequeueReusableCellWithIdentifier:@"SearchSuggestionCell" forIndexPath:indexPath];
    SearchSuggestModel * model = self.dataArr[indexPath.row];
    [cell showDataWithSuggeestModel:model];
    return cell;
    }
}

#pragma mark --UISearchBarDelegate



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //显示 cancel 按钮
    [_searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    //隐藏cancel 按钮
    [_searchBar setShowsCancelButton:NO animated:YES];
    return YES;//可以结束编辑模式
}

//点击cancel 的时候调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.text = @"";//清空内容
    //收键盘
    [_searchBar resignFirstResponder];
}

//点击search 按钮 调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    SearchResultController * searchVC =[[SearchResultController alloc]init];
    searchVC.keyWords = searchBar.text;
    //跳转
  [self.navigationController pushViewController:searchVC animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self dowloadRelativeDataWithSearchText:searchText];
}

- (void)dowloadRelativeDataWithSearchText:(NSString *)text{
    if (!text) {
        return;
    }
    if (self.dataArr) {
        [self.dataArr removeAllObjects];
    }
    text = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * url = [NSString stringWithFormat:kSearchUrl,text];
[_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = [[NSArray alloc]initWithArray:dict[@"suggestions"]];
        for (NSDictionary * suggetDict in arr) {
            SearchSuggestModel * suggestModel = [[SearchSuggestModel alloc]init];
            [suggestModel setValuesForKeysWithDictionary:suggetDict];
            [self.dataArr addObject:suggestModel];
        }
        
        [_searchController.searchResultsTableView reloadData];
    }
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    BBLog(@"下载失败");
}];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}



@end
