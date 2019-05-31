//
//  PatrolTaskMapVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolTaskMapVC.h"

#import "PatrolCustomAnnotationView.h"

@interface PatrolTaskMapVC ()<MAMapViewDelegate>

@property (nonatomic, strong) AnimatedAnnotation *animatedCarAnnotation;
@property (nonatomic, strong) NSArray<PatrolAnnotationModel*>* patrolAnnotations;
@end

@implementation PatrolTaskMapVC
@synthesize animatedCarAnnotation = _animatedCarAnnotation;

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    [self.view addSubview:self.mapView];
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = YES;///精度圈是否显示，默认YES
    r.showsHeadingIndicator = NO;
    [self.mapView updateUserLocationRepresentation:r];
    [self.topView removeFromSuperview];
    [self.view addSubview:self.topView];
    [self.navBar removeFromSuperview];
    [self.view addSubview:self.navBar];
    [self.navBar mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(NavBar_H));
    }];

    [self setBarTitle:@""];
    [self showNaBar:3];
}
- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,0, kSCREEN_WIDTH, kSCREEN_HEIGHT+20)];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
       _mapView.delegate = self;
        _mapView.showsUserLocation = NO;
        _mapView.zoomEnabled = YES;
        _mapView.zoomLevel = 16;
        _mapView.userTrackingMode = MAUserTrackingModeNone;
    }
    return _mapView;
}
-(void)addPatrolAnnotations:(NSArray<PatrolAnnotationModel*>*)patrolAnnotations{
    if (_patrolAnnotations.count) {
        [_mapView removeAnnotations:_patrolAnnotations];
    }
    _patrolAnnotations = patrolAnnotations;
    [_mapView addAnnotations:patrolAnnotations];
    if (_patrolAnnotations.count==0) {
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        
    }else if (_patrolAnnotations.count==1){
        
        PatrolAnnotationModel * firstModel = _patrolAnnotations.firstObject;
        [_mapView setCenterCoordinate:firstModel.coordinate animated:YES];

    }else{
        [_mapView showAnnotations:_patrolAnnotations animated:YES];
    }
    
    
    if (_mapView.zoomLevel>16) {
        [_mapView setZoomLevel:16 animated:YES];
    }
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView sendSubviewToBack:self.view];
//    [_mapView showAnnotations:_patrolAnnotations animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [_mapView showAnnotations:_patrolAnnotations animated:YES];
//    if (_mapView.zoomLevel>16) {
//        [_mapView setZoomLevel:16 animated:YES];
//    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hiddenNaBar];
}

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation)
    {
        
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
#pragma mark =====地图发生缩放比时掉用此方法 （修改：所有设备和设备组切换时地图放d大的问题）======
//- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction
//{
//    [mapView setZoomLevel:16];
//}
@end

