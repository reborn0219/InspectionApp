//
//  GJAppDelegate.h
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)NSString *STyle;

@property(assign,nonatomic)int WEIDU;
@property (nonatomic,strong) NSTimer *chatTimer;
-(void)startChatTimer;
-(void)stopChatTimer;

@end

