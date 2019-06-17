//
//  PSWODetailsImageCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsImageCell.h"
#import "ShowImageVC.h"
@interface PSWODetailsImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic, strong)ShowImageVC  *showImageVC;
@property (nonatomic,strong) NSMutableArray *imgModels;


@end
@implementation PSWODetailsImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _showImageVC = [[ShowImageVC alloc]init];
    _imgModels = [NSMutableArray array];
    _imgArr = [NSMutableArray array];
    [_imgArr addObject:_imageOne];
    [_imgArr addObject:_imageTwo];
    [_imgArr addObject:_imageThree];
    [_imgArr addObject:_imageFour];
    for (UIImageView *temImgV in _imgArr) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTouchUp:)];
        [temImgV addGestureRecognizer:tap];
        temImgV.userInteractionEnabled = YES;
    }
}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel
{
    if (cellModel==nil) {
        return;
    }
    [_imgModels removeAllObjects];
    NSArray *imgs = cellModel.ivv_json.images;
    for (int i =0; i<imgs.count; i++) {
        NSDictionary * dic = [imgs objectAtIndex:i];
        if (i<_imgArr.count) {
            UIImageView *tempImgV = [_imgArr objectAtIndex:i];
            [_imgModels addObject:[dic objectForKey:@"images"]];
            [tempImgV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"images_ico"]]];
        }
    }
    
}
-(void)imgTouchUp:(UIGestureRecognizer*)gestRecongizer{
    UIView * imgV = gestRecongizer.view;
    [_showImageVC setImageNoDeleWithImageArray:_imgModels withIndex:(int)(imgV.tag - 100)];
    [[PPViewTool getCurrentViewController] presentViewController:self.showImageVC animated:YES completion:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
