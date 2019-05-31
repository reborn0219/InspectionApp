//
//  PSWorkOrderViewController.m
//  InspectionApp
//
//  Created by guokang on 2019/5/29.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWorkOrderViewController.h"
#import "PSShowWorkOrderVC.h"
#import "DistributeWorkOrderVC.h"

@interface PSWorkOrderViewController ()
{
    UIViewController *currentVC;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabelHeight;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *listenImageV;
@property (weak, nonatomic) IBOutlet UIButton *workBtn;

@end

@implementation PSWorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNaBar:8];
    [self createUI];
}
- (void)createUI
{
    self.firstLabelHeight.constant = NavBar_H;
    self.stateLabel.layer.cornerRadius = 32.0f;
    self.stateLabel.layer.masksToBounds = YES;
    self.workBtn.layer.cornerRadius = 20.0f;
    self.workBtn.layer.masksToBounds = YES;
    [self listenImageAnimation];
}
- (void)listenImageAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.duration = 1.0f;
    //旋转效果累计，先旋转180度，接着再旋转180度，从而实现360度
    animation.cumulative = YES;
    animation.repeatCount = FLT_MAX;
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRect = CGRectMake(0, 0, self.listenImageV.frame.size.width, self.listenImageV.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [self.listenImageV.image drawInRect:CGRectMake(1, 1, self.listenImageV.frame.size.width - 2, self.listenImageV.frame.size.height - 2)];
    self.listenImageV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //围绕Z轴旋转，垂直于屏幕
    self.listenImageV.transform = CGAffineTransformRotate(self.listenImageV.transform,M_2_PI);
    [self.listenImageV.layer addAnimation:animation forKey:nil];
}
- (IBAction)starWorkAction:(id)sender {
    UIButton *btn = sender;
    if (btn.isSelected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"shouGong_green"] forState:(UIControlStateNormal)];
        [self listenImageAnimation];
        btn.selected = NO;
        self.stateLabel.text = @"听单中";
       
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"shouGong_gray"] forState:(UIControlStateNormal)];
            btn.selected = YES;
            self.stateLabel.text = @"准备中";
            [self.listenImageV.layer removeAllAnimations];
    }
    PSShowWorkOrderVC *workOrderVC = [[PSShowWorkOrderVC alloc]init];
    [workOrderVC showInVC:self];
}
- (void)segementDidSelected:(NSInteger)type
{
    if (type == 1) {
        
    }else{
        
    }
}
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            currentVC = newController;
        }else{
            currentVC = oldController;
            
        }
    }];
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
