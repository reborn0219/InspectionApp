//
//  PatrolCustomAnnotationView.m
//  物联宝管家
//
//  Created by yang on 2019/4/8.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolCustomAnnotationView.h"
#import "PatrolAnnotationModel.h"
#import "Masonry.h"
@interface PatrolCustomAnnotationView()
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIView * bottomView;
@property (nonatomic,strong)UILabel *titlelb;
@property (nonatomic,strong)PatrolAnnotationModel * model;

@end

@implementation PatrolCustomAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBounds:CGRectMake(0.f, 0.f,80, 40)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.bottomView];
        [self addSubview:self.backView];
        [self.backView addSubview:self.titlelb];
        [_titlelb setFrame:_backView.bounds];
        
    }
    return self;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(self.centerX+12,self.centerY-10,10,10)];
        [_bottomView setBackgroundColor:HexRGB(0x7EB1CD)];
        CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI_4);
        [_bottomView setTransform:transform];

    }
    return _bottomView;
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(self.centerX,self.centerY-5-40,80,40)];
        _backView.layer.cornerRadius = 5;
        [_backView setBackgroundColor:HexRGB(0x7EB1CD)];
    }
    return _backView;
}
-(UILabel *)titlelb{
    if (!_titlelb) {
        _titlelb = [[UILabel alloc]init];
        _titlelb.textColor = [UIColor whiteColor];
        _titlelb.textAlignment = NSTextAlignmentLeft;
        _titlelb.text = @"";
        _titlelb.numberOfLines = 2;
        _titlelb.font = [UIFont systemFontOfSize:12];
    }
    return _titlelb;
}
#pragma mark - Override
- (CGSize)sizeWithText:(NSString *)text
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    return [text sizeWithAttributes:attrDict];
}
- (void)setAnnotation:(id<MAAnnotation>)annotation
{
    [super setAnnotation:annotation];
    if (annotation==nil) {
        return;
    }
    if (_model) {
        return;
    }
    _model = annotation;
    self.titlelb.text = _model.annotation_name;
    if (_model.annotation_status.integerValue==4) {
        
        self.image = [UIImage imageNamed:@"equipment_state_3"];
        [self.backView setBackgroundColor:HexRGB(0x7EB1CD)];
        [self.bottomView setBackgroundColor:HexRGB(0x7EB1CD)];

    }else if (_model.annotation_status.integerValue==2) {
        self.image = [UIImage imageNamed:@"equipment_state_4"];
        [self.backView setBackgroundColor:HexRGB(0xF1B643)];
        [self.bottomView setBackgroundColor:HexRGB(0xF1B643)];

    }else if (_model.annotation_status.integerValue==3) {
        
        self.image = [UIImage imageNamed:@"equipment_state_2"];
        [self.backView setBackgroundColor:HexRGB(0x51D5B7)];
        [self.bottomView setBackgroundColor:HexRGB(0x51D5B7)];

    }else if (_model.annotation_status.integerValue==1) {
        
        self.image = [UIImage imageNamed:@"equipment_state_6"];
        [self.backView setBackgroundColor:HexRGB(0xEE816B)];
        [self.bottomView setBackgroundColor:HexRGB(0xEE816B)];
        
    }else if (_model.annotation_status.integerValue==6) {
        self.image = [UIImage imageNamed:@"equipment_state_4"];
        [self.backView setBackgroundColor:HexRGB(0xF1B643)];
        [self.bottomView setBackgroundColor:HexRGB(0xF1B643)];
        
    }else if (_model.annotation_status.integerValue==5) {
        
        self.image = [UIImage imageNamed:@"equipment_state_3"];
        [self.backView setBackgroundColor:HexRGB(0x7EB1CD)];
        [self.bottomView setBackgroundColor:HexRGB(0x7EB1CD)];
        
    }else{
        self.image = [UIImage imageNamed:@"equipment_state_1"];
        [self.backView setBackgroundColor:HexRGB(0x51BAF4)];
        [self.bottomView setBackgroundColor:HexRGB(0x51BAF4)];
    }
    [self.backView setFrame:CGRectMake(self.centerX,self.centerY-5-40,[self sizeWithText:self.titlelb.text].width+10,40)];
    [self.titlelb setFrame:CGRectMake(5, 0,[self sizeWithText:self.titlelb.text].width, 40)];
    
}

@end
