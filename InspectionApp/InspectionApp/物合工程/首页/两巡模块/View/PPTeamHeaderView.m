//
//  PPTeamHeaderView.m
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPTeamHeaderView.h"
#import "PatrolMembersCell.h"
#import "PPGroupInfoModel.h"
#import "PPNoDataView.h"

@interface PPTeamHeaderView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *cardLb;
@property (weak, nonatomic) IBOutlet UILabel *toolLb;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic, strong)PPNoDataView  *noDataView;
@property (nonatomic,strong)NSDictionary * infoDic;
@property (nonatomic,strong)PPGroupInfoModel * viewModel;

@end

@implementation PPTeamHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight=44;
    _tableView.rowHeight=UITableViewAutomaticDimension;
    [_tableView registerNib:[UINib nibWithNibName:@"PatrolMembersCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolMembersCell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _shadowView.layer.cornerRadius = 10;
    _shadowView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(0,0);
    _shadowView.layer.shadowOpacity = 0.2;
    _shadowView.layer.shadowRadius = 2;
    MJWeakSelf
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestData:weakSelf.infoDic];
    }];
}
-(void)requestData:(NSDictionary *)infoDic{
    MJWeakSelf
//    NSString *car_id = [infoDic objectForKey:@"car_id"];
    
        _infoDic = infoDic;
        [PatrolHttpRequest groupinfo:infoDic :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                
                weakSelf.viewModel = [PPGroupInfoModel yy_modelWithJSON:obj];
                weakSelf.titleLb.text = [NSString stringWithFormat:@"%@ %@",weakSelf.viewModel.car_name?:@"暂无车辆",weakSelf.viewModel.car_type?:@""];
                weakSelf.cardLb.text = weakSelf.viewModel.car_carid?:@"";
                if (weakSelf.viewModel.people_number) {
                    weakSelf.numberLabel.text = [NSString stringWithFormat:@"%@人",weakSelf.viewModel.people_number]?:@"";

                }else{
                    weakSelf.numberLabel.text = @"";

                }
                NSMutableArray * toolArr = [[NSMutableArray alloc]initWithCapacity:0];
                for (PPGroupInfoModelTool_list * toolModel in weakSelf.viewModel.tool_list) {
                    [toolArr addObject:toolModel.tool_name];
                }
                weakSelf.toolLb.text = [toolArr componentsJoinedByString:@" "];
                [weakSelf.tableView reloadData];
                
            }else{
                
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }];

  
}
#pragma mark -lazy loading -----
-(PPNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[[NSBundle mainBundle]loadNibNamed:@"PPNoDataView" owner:self options:nil]lastObject];
    }
    return _noDataView;
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _viewModel.member_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPGroupInfoModelMember_list * cellModel = [_viewModel.member_list objectAtIndex:indexPath.row];
    
    PatrolMembersCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolMembersCell"];
    [cell assignmentWithModel:cellModel];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row==0) {
        [cell setTeamOwner:YES];
    }else{
        [cell setTeamOwner:NO];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPGroupInfoModelMember_list * cellModel = [_viewModel.member_list objectAtIndex:indexPath.row];

    if (_block) {
        _block(cellModel,nil,indexPath);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.tableView.bounds), 40)];
//    UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 40)];
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本组人员(%@)人",_viewModel.people_number] attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
//    lb.attributedText = string;
//    
//    if (_viewModel.people_number.length>0) {
//        
//        [lb setHidden:NO];
//    }else{
//        [lb setHidden:YES];
//
//    }
//    [v addSubview:lb];
//    
//    return v;
//    
//    
//}
@end
