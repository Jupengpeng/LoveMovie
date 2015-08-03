//
//  GaodeViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "GaodeViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface GaodeViewController ()<MAMapViewDelegate>
{
    MAMapView * _mapView;
    
    //高德的搜索 POI
    AMapSearchAPI *_search;
}
@end

@implementation GaodeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    //配置用户key
    [MAMapServices sharedServices].apiKey = @"e2b477e69ba80071adf4fe45a2b7208d";
    //地图显示设置
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
    _mapView.region = MACoordinateRegionMake(self.coodinate, MACoordinateSpanMake(0.01, 0.01));
    _mapView.mapType = MAMapTypeStandard;
    
    _mapView.delegate = self; [self.view addSubview:_mapView];
    
    
    [self CreateAnnotationView];

}

- (void)CreateAnnotationView{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = self.coodinate;
    pointAnnotation.title = self.cinemaName;
    pointAnnotation.subtitle = self.address;
    [_mapView addAnnotation:pointAnnotation];
    
    
}
#pragma mark - <MAMapViewDelegate>

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES;
        //设置气泡可以弹出,默认为 NO annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO
        annotationView.animatesDrop = YES;
//        annotationView.
        annotationView.draggable = YES; //设置标注可以拖动,默认为 NO annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
    
}



//- (MAAnnotationView *)mapView:(MAMapView *)mapView
//            viewForAnnotation:(id<MAAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil) {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"v10_MapBlue"];
//        //设置中心心点偏移,使得标注底部中间点成为经纬度对应点 annotationView.centerOffset = CGPointMake(0, -18); return annotationView;
//    }
//    return nil;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}





@end
