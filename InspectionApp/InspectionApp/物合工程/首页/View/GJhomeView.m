//
//  GJhomeView.m
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//



#import "GJhomeView.h"
#import "UIImage+Extension.h"
#import "GJrunLabel.h"
#import "GJCommunityModel.h"

#define buttonY 204

#define wageButtonW self.bounds.size.width/5
@interface GJhomeView()<WYScrollViewDelegate>

@end

@implementation GJhomeView
{
    NSString *state;
    NSString *complaint_nums;
    NSString *feedback_nums;
    NSString *repair_nums;
    NSString *uploadUrl;
    UIView *WageView;
    UIView *functionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receivepushmessage) name:@"receivepushmessage" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HomewageNumData) name:@"HomewageNumData" object:nil];

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = viewbackcolor;
        self.atableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, 5000)];
        self.atableview.backgroundColor = viewbackcolor;
        self.atableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        self.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self reloadNumData];
                // 结束刷新
        }];
        // 马上进入刷新状态
        [self.mj_header beginRefreshing];
        [self addSubview:self.atableview];
//        [self CarouselImage];
        [self createdwagebutton];
        [self createdfunctionUI];
    }
    return self;
}
//点击的哪个轮播图
-(void)scrollView:(GJWYScrollView *)scrollView clickImageAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}
//轮播图
-(void)CarouselImage
{
//    self._scrollView=[[GJSMS_Scroll_ImageView alloc]initWithSMS_ImageURLArr:urlArr IntervalTime:2.5 Frame:CGRectMake(0,0, W,W*0.4) PageControl:YES Pagenumber:NO TitleFrame:CGRectMake(0, 0, 0, 0)];

//    NSArray *arr2 = @[[UIImage imageNamed:@"111-新"],[UIImage imageNamed:@"444-新"],[UIImage imageNamed:@"banner-金砖640"]];
//    /**
//     *  通过代码创建
//     */
//    self.scrollView = [GJWYScrollView scrollViewWithImageArray:arr2 describeArray:nil];
//    //设置frame
//    self.scrollView.frame = CGRectMake(0, 0, W, W * 0.4);
//    //用代理处理图片点击
//    self.scrollView.delegate = self;
//    //设置每张图片的停留时间，默认值为5s，最少为2s
//    _scrollView.time = 3;
//    //设置分页控件的图片,不设置则为系统默认
//    [_scrollView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
//    //设置分页控件的位置，默认为PositionBottomCenter
//    _scrollView.pagePosition = PositionBottomCenter;
//    /**
//     *  修改图片描述控件的外观，不需要修改的传nil
//     *
//     *  参数一 字体颜色，默认为白色
//     *  参数二 字体，默认为13号字体
//     *  参数三 背景颜色，默认为黑色半透明
//     */
//    UIColor *bgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
//    UIFont *font = [UIFont systemFontOfSize:15];
//    UIColor *textColor = [UIColor greenColor];
//    [_scrollView setDescribeTextColor:textColor font:font bgColor:bgColor];
//    [self.atableview addSubview:_scrollView];
    
    
    
}
-(void)createdwagebutton
{
    
    WageView = [[UIView alloc]initWithFrame:CGRectMake(0, W*0.4+ 46, W,wageButtonW*2 + 2)];
    WageView.backgroundColor = [UIColor whiteColor];
    UILabel *uplable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    uplable.backgroundColor = gycoloers;
    UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW*2 + 1.5, W, 0.5)];
    downLable.backgroundColor = gycoloers;

    [WageView addSubview:uplable];
    [WageView addSubview:downLable];
    
    UIButton *sweepButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, wageButtonW*2, wageButtonW*2)];
    sweepButton.tag = 20;
    [sweepButton addTarget:self action:@selector(ButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(wageButtonW*2 - 0.5, 0, 0.5, wageButtonW*2)];
    linelable.backgroundColor = gycoloers;
    [sweepButton addSubview:linelable];
    sweepButton.backgroundColor = [UIColor whiteColor];
    UIImageView *sweepImage = [[UIImageView alloc]initWithFrame:CGRectMake(wageButtonW - 30, wageButtonW- 40, 60, 60)];
    sweepImage.image = [UIImage imageNamed:@"icon_n_332x"];
    UILabel *sweepLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sweepImage.frame)+10, wageButtonW*2, 20)];
    sweepLable.textColor = gycoloer;
    sweepLable.font = [UIFont fontWithName:geshi size:17];
    sweepLable.textAlignment = NSTextAlignmentCenter;
    sweepLable.text = @"智能门禁";

    
    UIButton *view1 = [[UIButton alloc]initWithFrame:CGRectMake(wageButtonW*2,1, wageButtonW*3, wageButtonW)];
    view1.tag = 3;
    UILabel *linelable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW - 0.5, wageButtonW * 3, 0.5)];
    linelable1.backgroundColor = gycoloers;
    [view1 addSubview:linelable1];
    
    [view1 addTarget:self action:@selector(ButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    view1.backgroundColor = [UIColor whiteColor];
    [view1 setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
//    未分配工单
    _NotAssignedLable = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW/2-25,wageButtonW*3 , 30)];

//    _NotAssignedLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, wageButtonW*3, 30)];
    _NotAssignedLable.font = [UIFont fontWithName:geshi size:40];
    _NotAssignedLable.textColor = FZColor(247, 99, 24);
    _NotAssignedLable.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0,  wageButtonW/2+5,wageButtonW*3, 20)];
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, wageButtonW*3, 20)];
    lable.text = @"未分配工单";
    lable.font = [UIFont fontWithName:geshi size:14];
    lable.textColor = gycoloer;
    lable.textAlignment = NSTextAlignmentCenter;

    
    
    UIButton *view2 = [[UIButton alloc]initWithFrame:CGRectMake(wageButtonW * 2,CGRectGetMaxY(view1.frame), wageButtonW * 1.5, wageButtonW - 1)];
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(wageButtonW * 1.5 - 0.5, 0, 0.5, wageButtonW)];
    lineLabel2.backgroundColor = gycoloers;
    [view2 addSubview:lineLabel2];
    [view2 addTarget:self action:@selector(complaintDidClicked) forControlEvents:UIControlEventTouchUpInside];
    view2.backgroundColor = [UIColor whiteColor];
    [view2 setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
//    今日投诉
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW/2+5, wageButtonW * 1.5,20)];
    lable2.text = @"今日投诉";
    lable2.font = [UIFont fontWithName:geshi size:14];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.textColor = gycoloer;
    _complaintLable = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW/2-25, wageButtonW * 1.5, 30)];
    _complaintLable.font = [UIFont fontWithName:geshi size:30];
    _complaintLable.font = [UIFont fontWithName:geshi size:30];
    _complaintLable.textColor = FZColor(247, 99, 24);
    _complaintLable.textAlignment = NSTextAlignmentCenter;
    
    UIButton *view3 = [[UIButton alloc]initWithFrame:CGRectMake(wageButtonW * 3.5,CGRectGetMaxY(view1.frame), wageButtonW * 1.5, wageButtonW - 1)];
    [view3 setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    view3.backgroundColor = [UIColor whiteColor];
    [view3 addTarget:self action:@selector(consultationDidCliked) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW/2+5, wageButtonW * 1.5 , 20)];
    lable3.text = @"今日咨询";
    lable3.font = [UIFont fontWithName:geshi size:14];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.textColor = gycoloer;
    _consultationLable = [[UILabel alloc]initWithFrame:CGRectMake(0, wageButtonW/2-25, wageButtonW * 1.5, 30)];
    _consultationLable.font = [UIFont fontWithName:geshi size:30];
    _consultationLable.font = [UIFont fontWithName:geshi size:30];
    _consultationLable.textColor = FZColor(247, 99, 24);
    _consultationLable.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:_NotAssignedLable];
    [view1 addSubview:lable];
    [view2 addSubview:lable2];
    [view2 addSubview:_complaintLable];
    [view3 addSubview:lable3];
    [view3 addSubview:_consultationLable];
    [sweepButton addSubview:sweepLable];
    [sweepButton addSubview:sweepImage];
    [WageView addSubview:sweepButton];
    [WageView  addSubview:view1];
    [WageView  addSubview:view2];
    [WageView  addSubview:view3];
    [self.atableview addSubview:WageView];
}

#pragma mark - 下面一堆小button
-(void)createdfunctionUI
{
    

   functionView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(WageView.frame), W, w * 3)];
    functionView.backgroundColor = viewbackcolor;
//        functionView.backgroundColor = [UIColor redColor];

    [self.atableview addSubview:functionView];
    [self buttonWithImageName:@"icon_n_112" textlable:@"维修工单" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(0, 0, w - 1, 78) Tag:1];
    
    [self buttonWithImageName:@"icon_n_112" textlable:@"安保工单" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w,0, w-1, 78) Tag:2];
    
    [self buttonWithImageName:@"巡检" textlable:@"巡检" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w*2,0, w-1, 78) Tag:3];
    
    [self buttonWithImageName:@"巡查" textlable:@"巡查" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w*3,0, w-1, 78) Tag:4];
    
    [self buttonWithImageName:@"紧急任务" textlable:@"紧急任务" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(0, 79, w-1, 78) Tag:5];
    
    [self buttonWithImageName:@"在线报事" textlable:@"在线报事" target:self action:@selector(ButtonDidClicked:) CGrect:CGRectMake(w, 79, w-1, 78) Tag:6];

    self.contentSize = CGSizeMake(W, CGRectGetMaxY(WageView.frame) + w * 3 + 50+79+79);
    
    
}
-(UIButton *)buttonWithImageName:(NSString *)imagename textlable:(NSString *)lable target:(id)target action:(SEL)action CGrect:(CGRect)rect Tag:(int)tags;
{
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = tags;
    UIImageView *imageview1;
    if (tags==3||tags==4||tags==5||tags==6) {
       imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake((W/4-23)/2,15,23, 23)];

    }else{
        imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake((W/4-34)/2, 10, 34, 34)];

    }
    
    imageview1.image = [UIImage imageNamed:imagename];
    imageview1.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *lables = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, W/4, 30)];
    lables.text = lable;
    lables.textColor = gycoloer;
    lables.font = [UIFont fontWithName:geshi size:14];
    lables.textAlignment = NSTextAlignmentCenter;
    [button addSubview:imageview1];
    [button addSubview:lables];
    [button setBackgroundImage:[UIImage imagewithColor:buttonHighcolor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [functionView  addSubview:button];
    return button;
}
-(void)reloadNumData
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
       // return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *property_ids = model.property_id;
    NSString *communitID = model.community_id;
    if (property_ids != nil && communitID != nil) {
        GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
        [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"service" andA:@"home" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id"] andValueArr:@[property_ids,communitID] andBlock:^(id dictionary)
         {
             
             

             
             state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];

                 if([state isEqualToString:@"0"])
             {
                 [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
             }else if ([state isEqualToString:@"-1"])
             {
                 [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
                 if ([userDefaults objectForKey:@"Menucomplaint_nums"] == nil) {
                     _complaintLable.text = @"0";
                     _consultationLable.text = @"0";
                     _NotAssignedLable.text = @"0";

                 }else
                 {
                     _complaintLable.text = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"Menucomplaint_nums"]];
                     _consultationLable.text = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"Menufeedback_nums"]];
                     _NotAssignedLable.text = [NSString stringWithFormat:@"%@",[userDefaults objectForKey:@"Menurepair_nums"]];
                 }
             }else if ([state isEqualToString:@"1"])
             {
                 
#pragma mark - 获取广告图
                 NSLog(@"获取广告图%@",dictionary);
                 NSArray *arr=[NSArray arrayWithArray:dictionary[@"return_data"][@"boot_adv"]];
                 
                 [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"adv"];
                 
                 for (int i=0; i<arr.count; i++) {
                     NSString *img_url=[NSString stringWithFormat:@"%@",arr[i][@"img_url"]];
                     
                     NSArray *stringArr = [img_url componentsSeparatedByString:@"/"];
                     NSString *imageName = stringArr.lastObject;
                     
                     // 拼接沙盒路径
                     NSString *filePath = [self getFilePathWithImageName:imageName];
                     NSLog(@"%@",filePath);
//                     [self removeALL];
                     
                     [self downloadAdImageWithUrl:img_url imageName:imageName];
                     
                     
                 }
                 
                 
                 _complaintLable.text = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"complaint_nums"]];
                 _consultationLable.text = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"feedback_nums"]];
                 _NotAssignedLable.text = [NSString stringWithFormat:@"%@",dictionary[@"return_data"][@"repari_data"][@"repair_nums"]];
                 [userDefaults setObject:dictionary[@"return_data"][@"complaint_nums"] forKey:@"Menucomplaint_nums"];
                 [userDefaults setObject:dictionary[@"return_data"][@"feedback_nums"] forKey:@"Menufeedback_nums"];
                 [userDefaults setObject:dictionary[@"return_data"][@"repair_nums"] forKey:@"Menurepair_nums"];
                 [userDefaults synchronize];
             }
             else if ([state isEqualToString:@"3"]){
                 NSString *info = dictionary[@"upgrade_info"][@"info"];
                 uploadUrl = dictionary[@"upgrade_info"][@"url"];
                 self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                 self.shengjialert.delegate = self;
                 [self.shengjialert show];
             }else if ([state isEqualToString:@"5"]){
                 [self alertToLoginMsg:dictionary[@"return_data"] withDelegate:self];

             }
             [self.mj_header endRefreshing];
         }];
    }else
    {
        NSLog(@"2222");
    }
}
-(void)removeALL{
    NSString *extension = @"";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    
}
//   获取路径
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

//下载
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}


-(void)alertToLoginMsg:(NSString *)str withDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alert.delegate = delegate;
    [alert show];
    alert.tag=9999;
}

-(void)ButtonDidClicked:(UIButton *)sender
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(HomeButtonClicked:)]) {
        [self.delegates HomeButtonClicked:sender];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}
-(void)receivepushmessage
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [userdefaults objectForKey:@"pushmessage"];
    self.lable1.text = str;
}
-(void)HomeButtonDidClicked:(UIButton *)sender
{
    
}
//投诉
-(void)complaintDidClicked
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(complaintClicked)]) {
        [self.delegates complaintClicked];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}
//咨询
-(void)consultationDidCliked
{
    if (self.delegates && [self.delegates respondsToSelector:@selector(consultationClicked)]) {
        [self.delegates consultationClicked];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==9999)
    {
        GJLoginViewController *log=[[GJLoginViewController alloc] init];
        [self.viewController presentViewController:log animated:YES completion:nil];
        
    }else{

    if (buttonIndex == 0) {
        [GJSVProgressHUD dismiss];
        [self.shengjialert removeFromSuperview];
    }else
    {
        [GJSVProgressHUD dismiss];
        //升级
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:uploadUrl]];
    }
    }
}
-(void)HomewageNumData
{
    [self reloadNumData];
}
@end
