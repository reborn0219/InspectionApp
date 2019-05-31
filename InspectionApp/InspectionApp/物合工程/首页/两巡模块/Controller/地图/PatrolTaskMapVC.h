//
//  PatrolTaskMapVC.h
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedAnnotation.h"
#import "AnimatedAnnotationView.h"
#import "PPBaseViewController.h"
#import "PatrolAnnotationModel.h"

@interface PatrolTaskMapVC :PPBaseViewController
@property (nonatomic, strong) MAMapView *mapView;
-(void)addPatrolAnnotations:(NSArray<PatrolAnnotationModel*>*)patrolAnnotations;
@end


