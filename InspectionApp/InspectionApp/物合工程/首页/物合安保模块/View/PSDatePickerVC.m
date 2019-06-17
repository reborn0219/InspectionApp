//
//  PSDatePickerVC.m
//  InspectionApp
//
//  Created by guokang on 2019/6/6.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSDatePickerVC.h"

@interface PSDatePickerVC ()
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation PSDatePickerVC
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
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.datePicker setDate:[NSDate date] animated:YES];
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:(UIControlEventValueChanged)];
}
- (void)dateChange:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy年 MM月 dd日";
    NSString *dateStr = [formatter  stringFromDate:picker.date];
}
- (IBAction)sureAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
