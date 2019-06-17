//
//  PSTranformWorkOrderVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/31.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSTranformWorkOrderVC.h"
#import "MyViewControllerCell.h"
#import "PPSelectCarVC.h"
#import "PSDatePickerVC.h"

@interface PSTranformWorkOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *littleBackView;
@property (weak, nonatomic) IBOutlet UITextView *resultTV;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic, strong)NSArray  *nameArr;
@property (nonatomic, strong)PPSelectCarVC  *selectMemberVC;
@property (nonatomic, strong)PSDatePickerVC  *datePicker;
@end
@implementation PSTranformWorkOrderVC
-(void)showInVC:(UIViewController *)VC {
    
    if (self.isBeingPresented) {
        return;
    }
    self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    /**
     *  根据系统版本设置显示样式
     */
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        self.modalPresentationStyle=UIModalPresentationOverFullScreen;
    }else {
        self.modalPresentationStyle=UIModalPresentationCustom;
    }
    [VC presentViewController:self animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bigView.layer.cornerRadius = 8.0f;
    self.bigView.clipsToBounds = YES;
    self.nameArr = @[@"请选择转移人员",@"请选择预约时间"];
    self.backView.layer.cornerRadius = 8.0f;
    self.resultTV.layer.cornerRadius = 8.0f;
    self.resultTV.layer.masksToBounds = YES;
    self.littleBackView.layer.cornerRadius = 8.0f;
    self.littleBackView.layer.shadowColor = HexRGB(0x000000).CGColor;
    self.littleBackView.layer.shadowOffset = CGSizeMake(1, 1);
    self.littleBackView.layer.shadowOpacity = 0.09;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH - 88, 98) style:(UITableViewStylePlain)];
     [self.tableView registerNib:[UINib nibWithNibName:@"MyViewControllerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyViewControllerCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.backView addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyViewControllerCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyViewControllerCell"];
    cell.titleLab.text = self.nameArr[indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        _selectMemberVC = [[PPSelectCarVC alloc]init];
        [_selectMemberVC showInVC:self Type:4];
    }else{
        _datePicker = [[PSDatePickerVC alloc]init];
        [_datePicker showInVC:self];
    }
}
-(IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmAction:(id)sender {
    
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
