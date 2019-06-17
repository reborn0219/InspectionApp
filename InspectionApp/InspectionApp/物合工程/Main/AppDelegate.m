//
//  AppDelegate.m
//  OneBAuction
//
//  Created by 刘帅 on 2019/4/6.
//  Copyright © 2019 刘帅. All rights reserved.
//

#import "AppDelegate.h"
#import "WHZLLoginViewController.h"
#import "PSHomePageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self selectRootController];
    return YES;
}

-(void)appConfig{

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -设置根控制器

- (void)selectRootController
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    NSNumber * is_login =  [[NSUserDefaults standardUserDefaults]objectForKey:@"IS_LOGIN"];
    if (is_login.boolValue) {
       
        PSHomePageViewController *homeVC = [[PSHomePageViewController alloc]initWithNibName:@"PSHomePageViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
        self.window.rootViewController = nav;
        [self.window makeKeyWindow];
    }else{
        
        WHZLLoginViewController *loginVC = [[WHZLLoginViewController alloc]initWithNibName:@"WHZLLoginViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
        [self.window makeKeyWindow];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    
    
}
@end
