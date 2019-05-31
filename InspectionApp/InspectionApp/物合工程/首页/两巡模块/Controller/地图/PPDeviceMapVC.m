//
//  PPDeviceMapVC.m
//  物联宝管家
//
//  Created by yang on 2019/4/28.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPDeviceMapVC.h"

@interface PPDeviceMapVC ()

@end

@implementation PPDeviceMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self addPatrolAnnotations:_annotationArr];

}
@end
