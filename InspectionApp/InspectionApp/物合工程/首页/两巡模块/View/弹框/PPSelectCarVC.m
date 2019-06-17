//
//  PPSelectCarVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPSelectCarVC.h"

@interface PPSelectCarVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,assign)BOOL isCar;
@property (nonatomic,copy)NSString *car_id;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong) PPCarModel * seletedModel;

@end

@implementation PPSelectCarVC

-(void)showInVC:(UIViewController *)VC Type:(NSInteger)type{
    _isCar = NO;
    _type = type;
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
-(void)showInVC:(UIViewController *)VC withArr:(NSArray *)titleArr{
    _isCar = NO;
    _titleArr = titleArr;
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
-(void)showInVC:(UIViewController *)VC {
    
    _isCar = YES;
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
- (IBAction)completeAction:(id)sender {
    ///完成事件
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block(_seletedModel,nil,0);
        
    }
}

- (IBAction)cancelAction:(id)sender {
    ///取消事件
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_isCar) {
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _latitude = @"";
    _longitude=@"";
//    _car_id = @"0";
//    _titleArr = @[@"冀A-33333",@"冀A-33333",@"冀A-33333",@"冀A-33333",@"冀A-33333",@"冀A-33333"];
//    [_pickerView reloadAllComponents];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _titleLb.text = _titleStr;
    [self requestCarData];
}
-(NSMutableArray *)carListArr{
    if (!_carListArr) {
        _carListArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _carListArr;
}
#pragma mark - 网络请求

-(void)requestCarData{
    
    
    if (_type==0) {

        //巡检

        [PatrolHttpRequest carlist:@{@"car_type":@"2"} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                
                NSDictionary * obj = data;
                NSArray * car_list = [obj objectForKey:@"car_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[PPCarModel class] json:car_list];
                [self.carListArr removeAllObjects];
                
                if (!_isChangeCar) {
                    PPCarModel * model = [[PPCarModel alloc]init];
                    model.car_card = @"暂不选择车辆";
                    model.car_id = @"0";
                    [self.carListArr addObject:model];
                }

                [self.carListArr addObjectsFromArray:modelArr];
                [_pickerView reloadAllComponents];
                
            }
            
        }];
    }else if(_type==1) {
        
        for (int i = 0; i<5; i++) {
            
            PPCarModel * model = [[PPCarModel alloc]init];
            if (i==0) {
                model.car_card = @"全部";
            }else if (i==1) {
                model.car_card = @"日";
            }else if (i==2) {
                model.car_card = @"周";
            }else if (i==3) {
                model.car_card = @"月";
            }else if (i==4) {
                model.car_card = @"年";
            }
            model.car_id = [NSString stringWithFormat:@"%d",i];
            [self.carListArr addObject:model];
            
        }
       
        
    }else if(_type==2) {
        ///巡查车辆
        [PatrolHttpRequest carlist:@{@"car_type":@"1"} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                
                NSDictionary * obj = data;
                NSArray * car_list = [obj objectForKey:@"car_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[PPCarModel class] json:car_list];
                [self.carListArr removeAllObjects];
                
                if (!_isChangeCar) {
                    PPCarModel * model = [[PPCarModel alloc]init];
                    model.car_card = @"暂不选择车辆";
                    model.car_id = @"0";
                    [self.carListArr addObject:model];
                }
                
                
                [self.carListArr addObjectsFromArray:modelArr];
                [_pickerView reloadAllComponents];
                
            }
            
        }];
    }else if(_type==3) {
        [_pickerView reloadAllComponents];
//        [PatrolHttpRequest getcommunitybylatlng:@{@"latitude":_latitude,@"longitude":_longitude} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//            
//            if (resultCode == SucceedCode) {
//                NSDictionary * obj = data;
//                NSArray * car_list = [obj objectForKey:@"community_list"];
//                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[PPCarModel class] json:car_list];
//                [self.carListArr removeAllObjects];
//                [self.carListArr addObjectsFromArray:modelArr];
//                [_pickerView reloadAllComponents];
//            }else{
//            }
//        }];
    }else if (_type == 4){
        self.view.alpha = 0;
        self.view.backgroundColor = [UIColor clearColor];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _carListArr.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    PPCarModel * model = [_carListArr objectAtIndex:row];
    _seletedModel = [_carListArr objectAtIndex:0];
    if (_type==3) {
        return model.community_name;
    }
    return model.car_card;
   
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _seletedModel = [_carListArr objectAtIndex:row];
    
}
@end
