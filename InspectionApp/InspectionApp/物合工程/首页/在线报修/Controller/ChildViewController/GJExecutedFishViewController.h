//
//  GJExecutedFishViewController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/17.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJExecutedFishViewController : UIViewController
@property(nonatomic,assign)id<EXEFishChildVCDelegates>exefishChildDelegates;
//@property(nonatomic,strong)NSDictionary *receIveDataDict;
@property(nonatomic,assign)BOOL isAnBao;
@property(nonatomic,strong)NSString *repairdIDStr;
@end
