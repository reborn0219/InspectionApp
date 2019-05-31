//
//  PPSelectCarVC.h
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPCarModel.h"

@interface PPSelectCarVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (nonatomic,copy)ViewsEventBlock block;
@property (nonatomic,strong)NSMutableArray *carListArr;
@property (nonatomic,assign)BOOL isChangeCar;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,copy)NSString * task_id;
@property (nonatomic,copy)NSString * titleStr;
@property (nonatomic,strong)NSArray * titleArr;
-(void)showInVC:(UIViewController *)VC;
-(void)showInVC:(UIViewController *)VC withArr:(NSArray *)titleArr;
-(void)showInVC:(UIViewController *)VC Type:(NSInteger)type;

@end
