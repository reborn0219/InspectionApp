//
//  MLMarkCompletedVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/16.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLMarkCompletedVC : UIViewController
@property(nonatomic,assign)id<EXEFishChildVCDelegates>exefishChildDelegates;
//@property(nonatomic,strong)NSDictionary *receIveDataDict;
@property(nonatomic,assign)BOOL isAnBao;
@property(nonatomic,strong)NSString *repairdIDStr;
@end
