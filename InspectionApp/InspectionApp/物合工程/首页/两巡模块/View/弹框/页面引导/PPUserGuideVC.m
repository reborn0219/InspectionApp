//
//  PPUserGuideVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPUserGuideVC.h"

@interface PPUserGuideVC ()

@end

@implementation PPUserGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"showguide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
