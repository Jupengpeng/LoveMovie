//
//  NewsDetailViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}

@property (nonatomic,strong) UIWebView * webView;

@property (nonatomic,strong) NSMutableArray * relationsArr;
@end

@implementation NewsDetailViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    ;
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.relationsArr) {
        self.relationsArr = [[NSMutableArray alloc]init];
    }
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    [self initUI];
    
    [self initData];
}

- (void)pop{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-113)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    UIView * funcLabel  = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 49)];
    funcLabel.backgroundColor= myLight;
    //评论按钮
    UIButton * commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 25, 25)];
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"icon_comment 4"] forState:UIControlStateNormal];
    [funcLabel addSubview:commentBtn];
    [commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    //评论角标
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(commentBtn.frame.size.width-15, 0,20, 12)];
    self.numberLabel.backgroundColor = [UIColor redColor];
    self.numberLabel.font = [UIFont systemFontOfSize:13.0];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.layer.cornerRadius = 6;
    self.numberLabel.clipsToBounds = YES;
    [commentBtn addSubview:self.numberLabel];
    //相关电影按钮
    UIButton * relationBtn = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/2-60, 10, 120, 30) borderColor:[UIColor blackColor] borderWidth:0.6f titleColor:[UIColor blackColor] adjustWidth:YES textAligment:NSTextAlignmentCenter target:self action:@selector(relationClick:)];
    [relationBtn setTitle:@"相关电影/影人" forState:UIControlStateNormal];
    relationBtn.clipsToBounds = YES;
    relationBtn.layer.cornerRadius = 15;
    [funcLabel addSubview:relationBtn];
    
    
    self.contentBtn= [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width-70, 10, 60, 30) borderColor:[UIColor blackColor] borderWidth:0.6f titleColor:[UIColor blackColor] adjustWidth:YES textAligment:NSTextAlignmentCenter target:self action:@selector(contentClick:)];
    [_contentBtn setTitle:@"详情" forState:UIControlStateNormal];
    [_contentBtn setTitle:@"收起" forState:UIControlStateSelected];
    _contentBtn.clipsToBounds = YES;
    _contentBtn.layer.cornerRadius = 15;
    [funcLabel addSubview:_contentBtn];
    
    
    [self.view addSubview:funcLabel];
    
    //相关电影和影人view
    self.relationView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0)];
    self.relationView.clipsToBounds = YES;
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    self.relationView.backgroundColor = [UIColor whiteColor];

    titleLabel.text = @"相关电影/影人";
    titleLabel.layer.borderWidth = 0.5f;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.relationView addSubview:titleLabel];
    [self.view addSubview:self.relationView];
    
    
    self.blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-49)];
    self.blackView.backgroundColor =   [[UIColor blackColor]colorWithAlphaComponent:0.8];
}
//跳转进入评论界面
- (void)commentClick:(UIButton *)button{
    if (self.contentBtn.selected) {
        self.webView.frame = CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
        self.contentBtn.selected = NO;
    }
    [self.blackView removeFromSuperview];

    self.relationView.frame =CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
    
    
    NewsCommentsController * cVC= [[NewsCommentsController alloc]init];
    [self.navigationController pushViewController:cVC animated:YES];
    
    
    
}
//相关
- (void)relationClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        //添加视图
        UIScrollView * scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0,60 , kScreenSize.width, 150)];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.relationView addSubview:scrollView];
        CGFloat w = 70;
        for (int i = 0; i < self.relationsArr.count; i ++) {
            RelationsModel * relatedModel = self.relationsArr[i];
            UIFont * font = [UIFont systemFontOfSize:11.0f];
            UIView * relatedView=  [[UIView alloc]initWithFrame:CGRectMake(10 + (10+w)*i, 5, w, 155)];
            UIButton * relatedButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, w, 100)];
            relatedButton.clipsToBounds = YES;
            [relatedButton setContentMode:UIViewContentModeScaleAspectFill];
            CGFloat h = [LZXHelper textHeightFromTextString:relatedModel.name width:w fontSize:11.0f];
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(relatedButton.frame)+5, w, h)];
            titleLabel.numberOfLines = 0;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font  = font;
            //加载数据
            [relatedButton sd_setBackgroundImageWithURL:[NSURL URLWithString:relatedModel.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];
            
            titleLabel.text = relatedModel.name;
            
            
            [relatedView addSubview:relatedButton];
            [relatedView addSubview:titleLabel];
            if (relatedModel.type==1) {
                UILabel * yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,5+ CGRectGetMaxY(titleLabel.frame), w, 10)];
                yearLabel.font = font;
                yearLabel.textAlignment = NSTextAlignmentCenter;
                yearLabel.text  =  relatedModel.year;
                [relatedView addSubview:yearLabel];
                [relatedButton addTarget:self action:@selector(movieClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [relatedButton addTarget:self action:@selector(actorClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            relatedButton.tag = relatedModel.id;
            [scrollView addSubview:relatedView];
        }
        scrollView.contentSize = CGSizeMake(10+(10+w)*self.relationsArr.count, 0);
        
        //显示阴影和添加视图
        [self.navigationController.view addSubview:self.blackView];
        [self.navigationController.view addSubview:self.relationView];
        //显示动画
        [UIView animateWithDuration:0.25 animations:^{

            self.relationView.frame = CGRectMake(0, kScreenSize.height-210-49, kScreenSize.width, 210);

        }];

        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.blackView removeFromSuperview];
            self.relationView.frame =CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
        }];
    }
    
    
}
//相关电影
- (void)movieClick:(UIButton *)button{
    
}
//相关演员
- (void)actorClick:(UIButton *)button{
    
}

//改变 webview 显示文字说明
- (void)contentClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.navigationController.view addSubview:self.blackView];
        [self.navigationController.view addSubview:self.webView];
        [self.webView loadHTMLString:self.content baseURL:nil];

        [UIView animateWithDuration:0.25 animations:^{
            self.webView.frame = CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-113);
        }];
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.blackView removeFromSuperview];
        self.webView.frame = CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
        }];

    }

}

- (void)initData{
    NSString * url = [NSString stringWithFormat:kNewsDetailUrl,self.newsId];
    
    
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.newsDetailModel = [[NewDetailModel alloc]init];
            [self.newsDetailModel setValuesForKeysWithDictionary:dict];
            [self showWebviewWithDetailModel:self.newsDetailModel];

            
            for (NSDictionary * relationDict in self.newsDetailModel.relations) {
                RelationsModel * model = [[RelationsModel alloc]init];
                [model setValuesForKeysWithDictionary:relationDict];
                [self.relationsArr addObject:model];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
}

- (void)showWebviewWithDetailModel:(NewDetailModel *)model{
    
    //给content添加标题
    self.content=[NSMutableString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"<h2>%@</h2>",model.title], model.content];
//    [_content insertString:[NSString stringWithFormat:@"<h2>%@</h2>",model.title] atIndex:0];
    
    
    
    
    self.numberLabel.text= [NSString stringWithFormat:@"%d",model.commentCount];

    //有图片
    if (model.images) {
        NSMutableArray * imagesArr= [[NSMutableArray alloc]init];
        //开始标题
        [self addTitleViewWithTitle:[NSString stringWithFormat:@"%d/%lu",1,(unsigned long)self.newsDetailModel.images.count]];

        
        
        self.webView.frame = CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
        
        
        
        
        UIScrollView * mainScrolView=  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-113)];
        
        mainScrolView.backgroundColor = [UIColor redColor];
        for (NSDictionary * dict in model.images) {
            NewsImageModel * model = [[NewsImageModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [imagesArr addObject:model];
        }
        self.imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width,mainScrolView.frame.size.height)];
        self.imagesScrollView.pagingEnabled = YES;
        self.imagesScrollView.contentSize = CGSizeMake(kScreenSize.width*imagesArr.count, 0);
        self.imagesScrollView.backgroundColor = [UIColor blackColor];
        self.imagesScrollView.delegate = self;
        for (int i = 0; i < imagesArr.count; i ++) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, self.imagesScrollView.frame.size.height)];
            NewsImageModel * imageModel = imagesArr[i];
            imageView.clipsToBounds = YES;
            [imageView setContentMode: UIViewContentModeScaleAspectFit];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url1] placeholderImage:[UIImage imageNamed:@"empty"]];
            
            
            UILabel * blackLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,imageView.frame.size.height-60, kScreenSize.width, 60)];
            blackLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
            NSString * labelStr = [NSString stringWithFormat:@"  %@\n\n  %@",model.title,imageModel.desc];
            
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelStr];
            
            
            //为所有文本设置字体
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, [labelStr length])];
            //将  图片说明”两字字体颜色设置为灰色
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, [labelStr length])];
            
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, [model.title length]+2)];
            //将 标题 字体颜色设置为红色
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [model.title length])];
            
            blackLabel.attributedText = attributedString;
            blackLabel.textColor = [UIColor whiteColor];
            blackLabel.numberOfLines = 0;
            blackLabel.adjustsFontSizeToFitWidth = YES;
            
            [imageView addSubview:blackLabel];
            [self.imagesScrollView addSubview:imageView];
        }
        
        [mainScrolView addSubview:_imagesScrollView];
        [self.view addSubview:mainScrolView];
        
        
        
        
        
        
        
    }else{

        
        [_contentBtn setHidden:YES];
        [self.webView loadHTMLString:self.content baseURL:nil];
    
    }
    
    
}
#pragma mark - <UIWebViewDelegate>
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    //html便利图片 改变宽度
    
    NSString* content = [NSString stringWithFormat:@"var images = document.images;"
                         "for(var i=0;i<images.length;i++){"
                         "    images[i].width = %f"
                         "}",kScreenSize.width-10];
    
    [self.webView stringByEvaluatingJavaScriptFromString:content];
    [SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i =  scrollView.contentOffset.x/kScreenSize.width;
    [self addTitleViewWithTitle:[NSString stringWithFormat:@"%d/%lu",i+1,(unsigned long)self.newsDetailModel.images.count]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
