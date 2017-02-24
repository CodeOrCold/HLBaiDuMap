//
//  ViewController.m
//  HLBaiDuMap
//
//  Created by 杨海龙 on 2017/2/24.
//  Copyright © 2017年 杨海龙 趣高科技. All rights reserved.
//

#import "ViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface ViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate>

//地图视图
@property (nonatomic, strong)BMKMapView *mapView;

@property (nonatomic, strong)BMKPoiSearch *search;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    
    /**地图类型
     BMKMapTypeNone       = 0,               ///< 空白地图
     BMKMapTypeStandard   = 1,               ///< 标准地图
     BMKMapTypeSatellite  = 2,               ///< 卫星地图
     */
    [_mapView setMapType:1];
    
    //交通路况
    [_mapView setTrafficEnabled:YES];
    
    //热力图
    [_mapView setBaiduHeatMapEnabled:NO];
    
    _mapView.minZoomLevel = 100.0;
    _mapView.maxZoomLevel = 1000.0;
    
    //初始化检索对象
    _search =[[BMKPoiSearch alloc]init];
    _search.delegate = self;
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    CLLocationCoordinate2D coor;
    coor.latitude = 30.2052212978586;
    coor.longitude = 120.21039239301257;
    option.location = coor;
    option.radius = 1000;
    option.keyword = @"小吃";
    BOOL flag = [_search poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    
    self.view = _mapView;
    self.title = @"HLBaiDuMap";
    
}

-(void)viewDidAppear:(BOOL)animated{
//    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 30.2052212978586;
//    coor.longitude = 120.21039239301257;
//    annotation.coordinate = coor;
//    annotation.title = @"天安门";
//    annotation.subtitle = @"北京市";
//    
//    [_mapView addAnnotation:annotation];

}

//设置代理
-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    
    _mapView.delegate = self;
    
}

//取消代理
-(void)viewDidDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _search.delegate = nil;

}

#warning =====BMKMapViewDelegate=====
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.image = [UIImage imageNamed:@"annotation"];
        newAnnotationView.frame = CGRectMake(0, 0, 40, 40);
        
        return newAnnotationView;
    }
    return nil;

}

-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    NSLog(@"click...");

}

#warning =====BMKSearchDelegate=====
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
