//
//  PSWODetailsVideoCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsVideoCell.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"
@interface PSWODetailsVideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *videoImageV;
@property (weak, nonatomic) IBOutlet UILabel *noVideoLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong) NewOrderModelIvv_json *videoModel;

@end
@implementation PSWODetailsVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)assignmentWithModel:(OrderDetailModel *)cellModel
{
    if (cellModel) {
        _videoModel = cellModel.ivv_json;
        if (_videoModel.video.count) {
            NSDictionary *dict = [_videoModel.video objectAtIndex:0];
            NSString *video_img_ico =[dict objectForKey:@"video_img_ico"];
            [_videoImageV sd_setImageWithURL:[NSURL URLWithString:video_img_ico]];
        }
    }
}
- (IBAction)playVideoAction:(id)sender {
    if (_videoModel.video.count) {
        NSDictionary *dict = [_videoModel.video objectAtIndex:0];
        NSString *videoUrl =[dict objectForKey:@"video"];
        if (videoUrl.length) {
            GJZXVideo *video = [[GJZXVideo alloc] init];
            video.playUrl = videoUrl;
            GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
            vc.video = video;
            vc.hidesBottomBarWhenPushed = YES;
            [[PPViewTool getCurrentViewController].navigationController pushViewController:vc animated:YES];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
