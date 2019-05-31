//
//  PPLocationMapVC.m
//  物联宝管家
//
//  Created by yang on 2019/4/23.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPLocationMapVC.h"
#import "PatrolMatterSubmitVC.h"
#import "PPViewTool.h"
#import "PPSelectCarVC.h"
#import "PatrolUrgentOptionDetailVC.h"
#import "UrgenttaskDetailModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
#import "lame.h"
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"
#import "PatrolAnnotationModel.h"
#import "MaatterSubmitModel.h"
#import "PatrolCustomAnnotationView.h"
#import "PatrolAnnotationModel.h"
#import "UserManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "PatrolAnnotationModel.h"

@interface PPLocationMapVC ()<MAMapViewDelegate,AMapSearchDelegate>{
  
}
@property (strong, nonatomic) MAMapView *mapView;

@property (nonatomic, strong) PatrolAnnotationModel *annotation;

@property (nonatomic,strong) AMapSearchAPI *mapSearch;

@end

@implementation PPLocationMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self creatUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"位置信息"];

    [_mapView addAnnotation:self.annotionModel];
    [_mapView setCenterCoordinate:self.annotionModel.coordinate];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}

-(void)creatUI{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,NavBar_H, kSCREEN_WIDTH, kSCREEN_HEIGHT-NavBar_H)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;
    [self.mapView updateUserLocationRepresentation:r];
    _mapView.zoomLevel = 16;
    [self.view addSubview:_mapView];
}
-(AMapSearchAPI *)mapSearch{
    if (!_mapSearch) {
        _mapSearch= [[AMapSearchAPI alloc] init];
        self.mapSearch.delegate = self;
    }
    return _mapSearch;
}
-(PatrolAnnotationModel*)annotation{
    if (!_annotation) {
        _annotation = [[PatrolAnnotationModel alloc] init];
        _annotation.annotation_name = @"当前位置";
        _annotation.annotation_status = @"4";
    }
    return _annotation;
}
#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[PatrolAnnotationModel class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        PatrolCustomAnnotationView *annotationView = (PatrolCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[PatrolCustomAnnotationView alloc] initWithAnnotation:annotation
                                                                    reuseIdentifier:reuseIndetifier];
        }
        return annotationView;
    }
    return nil;
    
    
}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        _annotation.annotation_name = response.regeocode.formattedAddress;
        [_mapView addAnnotation:_annotation];
        
    }
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

@end

