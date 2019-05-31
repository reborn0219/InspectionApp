//
//  PPCommunityOrderListVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPCommunityOrderListVC.h"
#import "PatrolOrderDetailVC.h"
#import "PatrolDeviceCell.h"
#import "PatrolTaskMapVC.h"
#import "CATCurveProgressView.h"
#import "PPDeviceGroupModel.h"
#import "LSCircularProgressView.h"

@interface PPCommunityOrderListVC ()<CATCurveProgressViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)NSInteger noStr;
@property (weak, nonatomic) IBOutlet UIView *teamTopView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLb;
@property (weak, nonatomic) IBOutlet UILabel *abnomalLb;
@property (weak, nonatomic) IBOutlet UILabel *inspectLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UIButton *btn_1;
@property (weak, nonatomic) IBOutlet UIButton *btn_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_3;
@property (weak, nonatomic) IBOutlet UIButton *btn_4;
@property (weak, nonatomic) IBOutlet UIView *v_1;
@property (weak, nonatomic) IBOutlet UIView *v_2;
@property (weak, nonatomic) IBOutlet UIView *v_3;
@property (weak, nonatomic) IBOutlet UIView *v_4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_top;

@property (nonatomic,strong) NSMutableArray *deviceArr;
@property (nonatomic,strong) PPDeviceGroupModel *groupModel;
@property (nonatomic,strong) LSCircularProgressView *gradientArcChart;
@property (nonatomic, strong)NSString  *work_sheet_status;

@end

@implementation PPCommunityOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.work_sheet_status = @"0";
    _view_top.constant = NavBar_H;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight=44;
    _tableView.rowHeight=UITableViewAutomaticDimension;
    [_tableView registerNib:[UINib nibWithNibName:@"PatrolDeviceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolDeviceCell"];
    _deviceArr = [NSMutableArray array];
    _teamTopView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _teamTopView.layer.shadowOffset = CGSizeMake(0,0);
    _teamTopView.layer.shadowOpacity = 0.2;
    _teamTopView.layer.shadowRadius = 2;
    
    _gradientArcChart = [[LSCircularProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-90,30,90,90)];
    [_teamTopView addSubview:_gradientArcChart];
    MJWeakSelf
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}
-(void)requestData{
    
        MJWeakSelf
    self.tableView.tableHeaderView = nil;
    [PatrolHttpRequest groupdevicelist:@{@"work_id":self.work_id,@"group_id":self.group_id ,@"work_sheel_status":self.work_sheet_status} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                
                [_deviceArr removeAllObjects];
                _groupModel = [PPDeviceGroupModel yy_modelWithJSON:obj];
                [_gradientArcChart setProgress:_groupModel.device_number Inspection:_groupModel.inspected_number Abnormal:_groupModel.abnormal_number];
                [_deviceArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPDeviceListModel class] json:[obj objectForKey:@"device_list"]]];
                _teamNameLb.text= _groupModel.group_name;
                _abnomalLb.text = [NSString stringWithFormat:@"已巡检设备%@/%@",_groupModel.inspected_number,_groupModel.device_number];
                self.inspectLb.text = [NSString stringWithFormat:@"%@个异常设备",_groupModel.abnormal_number];
                self.addressLb.text = _groupModel.group_no;
                
                [weakSelf.tableView reloadData];
                if (_deviceArr.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
//                "device_number" = 10;
//                "group_id" = 1;
//                "group_name" = "10\U53f7\U697c\U8bbe\U5907\U7ec4";
//                "group_no" = SBZ20190328000001;
//                "inspected_number" = 0;
//                "work_id" = 1;
//                "abnormal_number" = 0;

            }else{
               weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];

        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"设备组信息"];
    [self requestData];

}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
    
}

- (IBAction)topBtnAction:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    [_btn_1 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_2 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_3 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_4 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_v_2 setHidden:YES];
    [_v_3 setHidden:YES];
    [_v_4 setHidden:YES];
    [_v_1 setHidden:YES];
    if (btn.tag == 100) {
        [_v_1 setHidden:NO];
        [_btn_1 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        self.work_sheet_status  = @"0";
    }else if (btn.tag == 101) {
        [_v_2 setHidden:NO];
        [_btn_2 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
           self.work_sheet_status  = @"2";
    }else if (btn.tag == 102) {
        [_v_3 setHidden:NO];
        [_btn_3 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
          self.work_sheet_status  = @"3";
    }else if (btn.tag == 103) {
        
        [_v_4 setHidden:NO];
        [_btn_4 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
       self.work_sheet_status  = @"1";
    }
    [self requestData];
    
}
#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _deviceArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPDeviceListModel * model = [_deviceArr objectAtIndex:indexPath.row];
    PatrolDeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolDeviceCell"];
    [cell assignmentWithModel:model];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PatrolOrderDetailVC * pcolVC = [[PatrolOrderDetailVC alloc]init];
    pcolVC.work_id = self.work_id;
    PPDeviceListModel *deviceModel = [_deviceArr objectAtIndex:indexPath.row];
    pcolVC.device_id = deviceModel.device_id;
    pcolVC.work_sheet_id = deviceModel.work_sheet_id;
    [self.navigationController pushViewController:pcolVC animated:YES];
    
}
-(CAGradientLayer *)setGradualChangingColor:(UIView *)view{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 215, 40);
    //  创建渐变色数组，需要转换为CGColor颜色 （因为这个按钮有三段变色，所以有三个元素）
    gradientLayer.colors = @[(__bridge id)HexRGB(0x51BAF4).CGColor,(__bridge id)HexRGB(0x38E1B9).CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    //  设置颜色变化点，取值范围 0.0~1.0 （所以变化点有三个）
    gradientLayer.locations = @[@0,@1];
    gradientLayer.cornerRadius = 20;

    return gradientLayer;
    
}

-(void)setGradient:(UIView *)view{
    [view.layer insertSublayer:[self setGradualChangingColor:view] atIndex:0];
}

@end
