//
//  XSDLocationTools.m
//  物联宝管家
//
//  Created by yang on 2019/1/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "XSDLocationTools.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "JPUSHService.h"
#import "GJAppDelegate.h"
#define LAST_LONG  @"last_longitude"  // 上次上传位置的经度
#define LAST_LATI  @"last_latitude"  // 上次上传位置的纬度


@interface XSDLocationTools ()<CLLocationManagerDelegate>
{
    //dispatch_source_t _timer;
    CLLocationCoordinate2D _newCoor;
}
// 1.设置位置管理者属性
@property (nonatomic, strong) CLLocationManager *lcManager;
//@property (nonatomic, assign) BOOL isRequest;
@property (nonatomic, strong) NSTimer *uploadTimer;

@end

@implementation XSDLocationTools

+ (XSDLocationTools *)shareInstance {
    static XSDLocationTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XSDLocationTools alloc] init];
        [instance p_addNSNotificationObserver];
    });

    return instance;
}
-(void)stopLocationService{
    [self.lcManager stopUpdatingLocation];
    [self.uploadTimer setFireDate:[NSDate distantFuture]];
}
// 开启定位
- (void)startLocationService {
    if ([CLLocationManager locationServicesEnabled]) {
        // 创建位置管理者对象
        self.lcManager = [[CLLocationManager alloc] init];
        self.lcManager.delegate = self; // 设置代理
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        self.lcManager.distanceFilter = 5;
        self.lcManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)

        // 2、在Info.plist文件中添加如下配置：
        //（1）NSLocationAlwaysUsageDescription 授权使应用在前台后台都能使用定位服务
        //（2）NSLocationWhenInUseUsageDescription 授权使应用只能在前台使用定位服务
        // 两者也可以都写
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >=8.0 ) {
            // iOS0.0：如果当前的授权状态是使用是授权，那么App退到后台后，将不能获取用户位置，即使勾选后台模式：location
            [self.lcManager requestAlwaysAuthorization];
            [self.lcManager requestWhenInUseAuthorization];
        }

        // iOS9.0+ 要想继续获取位置，需要使用以下属性进行设置（注意勾选后台模式：location）但会出现蓝条
        if ([self.lcManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]) {
            //
            self.lcManager.allowsBackgroundLocationUpdates = YES;
        }

        [self.lcManager startUpdatingLocation]; // 开始更新位置
        [self.uploadTimer setFireDate:[NSDate distantPast]]; // 开启定时器
    }
}


/** 获取到新的位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *tempLocation = locations[0];
    _newCoor = AMapCoordinateConvert(CLLocationCoordinate2DMake(tempLocation.coordinate.latitude,tempLocation.coordinate.longitude), AMapCoordinateTypeGPS);
    [self uploadLocationTimer];
}
/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"获取定位失败");
}

/** 定位服务状态改变时调用*/
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}


// 直接上传用户位置
static NSInteger uploadCount = 1;
- (void)uploadUserLocationHandle:(CLLocationCoordinate2D)coor {

    NSDictionary *dic = @{@"longitude":@(coor.longitude),
                          @"latitude":@(coor.latitude)};
    __weak typeof(self)weakSelf = self;
   ///上传接口

}
// 定时上传位置
- (void)uploadLocationTimer {

//    if (canUpload) {
    
//#ifdef DEBUG
//    //do sth.
//#else
    
    MJWeakSelf
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"map" andA:@"set_people_position" andBodyOfRequestForKeyArr:@[@"lng",@"lat"] andValueArr:@[@(_newCoor.longitude),@(_newCoor.latitude)] andBlock:^(id dictionary)
         {
             NSLog(@"---%@",dictionary);
             NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];

             if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
                 
                 UIViewController *RootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
                 UIViewController *topVC = RootVC;

                 while (topVC.presentedViewController) {
                     
                     topVC = topVC.presentedViewController;
                     
                 }
              
             }
         }];
//    }
//#endif
    
}
- (void)closeAppClicked{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    //NSArray * arr=[NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"adv"]];
    
    for (id  key in dic) {
        NSString *lskey_str = (NSString *)key;
        if ([lskey_str isKindOfClass:[NSString class]]&&[lskey_str isEqualToString:@"showguide"]) {
            
        }else{
            [userDefaults removeObjectForKey:key];
        }
    }
    
    [userDefaults synchronize];
    [JPUSHService setTags:[NSSet setWithObjects:@"", nil] alias:@"" callbackSelector:@selector(kkk) object:self];
    [[NSUserDefaults standardUserDefaults]setObject:@(NO) forKey:@"IS_LOGIN"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[XSDLocationTools shareInstance]stopLocationService];

    GJAppDelegate *appDelegate = (GJAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate stopChatTimer];
    
}
-(void)kkk{}
// 监听用户登录的通知
- (void)p_addNSNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_loginNotification) name:@"user_did_login" object:nil];
}
- (void)p_loginNotification {
    // 用户登录, 就开始上传位置
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LATI];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LONG];
    if (!latitude || !longitude) return;
    // 读取本地的经纬度
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    [self uploadUserLocationHandle:location];
}

// 是否达到条件（判断距离 大于一定距离）上传位置
- (BOOL)isCanUpload:(CLLocationCoordinate2D)coor {

    //  下面代码相当于 NSUserDefaults 存取数据
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LATI];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LONG];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!latitude || !longitude) {
        //  下面代码相当于 NSUserDefaults 存取数据
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",coor.latitude] forKey:LAST_LATI];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",coor.longitude] forKey:LAST_LONG];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }

    //计算两点间的距离
  
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(latitude.doubleValue,longitude.doubleValue));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(coor.latitude,coor.longitude));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    NSLog(@"----物联宝管家移动距离：%f",distance);
    if (distance >=2) {
        //  下面代码相当于 NSUserDefaults 存取数据
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",coor.latitude] forKey:LAST_LATI];
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%f",coor.longitude] forKey:LAST_LONG];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

// 懒加载
- (NSTimer *)uploadTimer {
    if (!_uploadTimer) {
        _uploadTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(uploadLocationTimer) userInfo:nil repeats:YES];
    }
    return _uploadTimer;
}

@end

