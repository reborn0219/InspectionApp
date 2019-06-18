//
//  PSWOMarkFinishedWorkVC.m
//  InspectionApp
//
//  Created by guokang on 2019/6/6.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOMarkFinishedWorkVC.h"
#import "MyViewControllerCell.h"
#import "PSWOTextViewCell.h"
#import "OwnerSignatureVC.h"
#import "GJSYDatePicker.h"
@interface PSWOMarkFinishedWorkVC ()<UITableViewDelegate,UITableViewDataSource,SYDatePickerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSArray  *leftArr;
@property (nonatomic, strong)NSMutableArray  *dataArr;
@property (nonatomic,strong) GJSYDatePicker *picker;
@property (nonatomic,strong) UITextView *markTextV;
@property (nonatomic,strong) UITextField *moneyTextF;
@property (nonatomic,strong) NSIndexPath *controllerIndex;

@end

@implementation PSWOMarkFinishedWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showNaBar:2];
    [self setBarTitle:@"标记完工"];
    self.dataArr = [NSMutableArray array];
    self.leftArr = @[@"入户时间",@"出户时间",@"",@"消费材料",@"人工费用",@"住户承担金额",@"付款方式"];
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(14,NavBar_H+10,SCREEN_WIDTH-28,SCREEN_HEIGHT-NavBar_H-70)];
    v.layer.cornerRadius = 5;
    v.layer.shadowColor = SHADOW_COLOR.CGColor;
    v.layer.shadowOffset = CGSizeMake(0,0);
    v.layer.shadowOpacity = 0.2;
    v.layer.shadowRadius = 2;
    [self.view addSubview:v];
    [v addSubview:self.tableView];
    [self createUI];
}
- (void)createUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keybaordClickToBack)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 48, SCREEN_WIDTH, 48);
    [btn setTitle:@"提交" forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setBackgroundImage:[UIImage imageNamed:@"提交"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(clickToConfirmAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}
- (void)keybaordClickToBack
{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _controllerModel.repaird.paid_type = @"扫码支付";
    [self.tableView reloadData];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)clickToConfirmAction
{
    _controllerModel.repaird.work_remarks= [NSString stringWithFormat:@"%@",_markTextV.text];
    _controllerModel.repaird.service_charge= [NSString stringWithFormat:@"%@",_moneyTextF.text];
 _controllerModel.repaird.owner_cost = [NSString stringWithFormat:@"%f", _controllerModel.repaird.service_charge.floatValue+ _controllerModel.repaird.material_fee.floatValue];
    if (_controllerModel.repaird.come_in_time.length == 0) {
        [GJSVProgressHUD showErrorWithStatus:@"请选择服务开始时间！"];
        return;
    }else if(_controllerModel.repaird.come_out_time.length == 0)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请选择服务结束时间！"];
        return;
    }else if (_controllerModel.repaird.service_charge.length == 0)
    {
        [GJSVProgressHUD showErrorWithStatus:@"请输入服务费用！"];
        return;
    }
    OwnerSignatureVC * sigVC = [[OwnerSignatureVC alloc]init];
    sigVC.controllerModel = _controllerModel;
    [self.navigationController pushViewController:sigVC animated:YES];
        
}
-(UITableView *)tableView{
    if (!_tableView) {
    
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(1,1,SCREEN_WIDTH-26,SCREEN_HEIGHT-NavBar_H-68) style:UITableViewStylePlain];
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"MyViewControllerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyViewControllerCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWOTextViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWOTextViewCell"];
     
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2) {
        MyViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyViewControllerCell"];
        
        cell.titleLab.text = self.leftArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
                cell.detailsLab.text = _controllerModel.repaird.come_in_time;

                break;
            case 1:
                cell.detailsLab.text = _controllerModel.repaird.come_out_time;

                break;
            case 3:
                cell.detailsLab.text = _controllerModel.repaird.material_fee;

                break;
            case 4:
                cell.detailsLab.text = _controllerModel.repaird.service_charge;

                break;
            case 5:
                cell.detailsLab.text = _controllerModel.repaird.owner_cost;

                break;
            case 6:
                cell.detailsLab.text = _controllerModel.repaird.paid_type;
                
                break;
            default:
                break;
        }
        
        if (indexPath.row==0||indexPath.row ==1) {
            cell.clickBtn.hidden = NO;

        }else{
            cell.clickBtn.hidden = YES;
        }
      
        return cell;
    }else{
        PSWOTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSWOTextViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf
        cell.block = ^(id  _Nullable data, UIView * _Nullable view, NSIndexPath * _Nullable index) {
            
            weakSelf.controllerModel.repaird.work_remarks= [NSString stringWithFormat:@"%@",weakSelf.markTextV.text];
            weakSelf.controllerModel.repaird.service_charge= [NSString stringWithFormat:@"%@",weakSelf.moneyTextF.text];
            weakSelf.controllerModel.repaird.owner_cost = [NSString stringWithFormat:@"%.2f",weakSelf.controllerModel.repaird.service_charge.floatValue+ weakSelf.controllerModel.repaird.material_fee.floatValue];
            [weakSelf.tableView reloadData];
        };
        _markTextV = cell.markTV;
        _moneyTextF = cell.moneyTF;
        return cell;
    }
}
-(void)timecellDidClicked:(NSIndexPath *)indexPath
{
    _controllerIndex = indexPath;
    if (!self.picker) {
        self.picker = [[GJSYDatePicker alloc] init];
    }
    [self.picker showInView:self.view withFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300) andDatePickerMode:UIDatePickerModeDateAndTime];
    self.picker.delegate = self;
}
- (void)picker:(UIDatePicker *)picker ValueChanged:(NSDate *)date{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm";
    if (_controllerIndex.row == 0) {
        _controllerModel.repaird.come_in_time = [fm stringFromDate:date];
    }else if (_controllerIndex.row == 1) {
        _controllerModel.repaird.come_out_time = [fm stringFromDate:date];
    }
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2) {
        [self timecellDidClicked:indexPath];
    }
}


@end
