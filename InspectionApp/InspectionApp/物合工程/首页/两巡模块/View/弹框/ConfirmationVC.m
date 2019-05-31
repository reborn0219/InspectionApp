//
//  ConfirmationVC.m
//  物联宝管家
//
//  Created by guokang on 2019/5/13.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "ConfirmationVC.h"

@interface ConfirmationVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (nonatomic,copy) NSString *contentstr;

@end

@implementation ConfirmationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _backView.layer.cornerRadius = 8.0f;
    _backView.clipsToBounds = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _contentLb.text = _contentstr;
}
-(void)showInVC:(UIViewController *)VC withTitle:(NSString*)content{
    [super showInVC:VC];
    _contentstr = content;
    
}
- (IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block(0);
    }
}
- (IBAction)sureAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block(1);
    }
}
@end
