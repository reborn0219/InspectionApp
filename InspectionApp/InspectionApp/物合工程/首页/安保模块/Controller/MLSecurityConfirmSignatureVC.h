//
//  MLSecurityConfirmSignatureVC.h
//  物联宝管家
//
//  Created by yang on 2019/1/16.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MLSecurityConfirmSignatureVC : UIViewController
@property(strong,nonatomic)UIImage *NameImg;

//   处理工单
@property(strong,nonatomic)NSString *repair_id;



//  标记完工
@property(strong,nonatomic)NSDictionary *WGDic;
@property(nonatomic,assign)BOOL isBefore;



@end
