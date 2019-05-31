//
//  GJFZPprovinceView.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/12.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZPprovinceView.h"

@implementation GJFZPprovinceView

@synthesize tv,tableArray,MenuButton,leftLable,rightLable;

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height < 150) {
        frameHeight = 150;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight - 30;
    frame.size.height = 30.0f;
    self=[super initWithFrame:frame];
    if(self){
        showList = NO; //默认不显示下拉框
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor whiteColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        MenuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        [MenuButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width/2 - 10, 39.5)];
        titleLable.backgroundColor = [UIColor whiteColor];
        titleLable.text = @"请选择车牌省份 :";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width - 40, 39.5)];
        imageView.image = [UIImage imageNamed:@"mlgj-2x51"];
        rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 39.5, 0, 39.5, 39.5)];
        rightImageView.image = [UIImage imageNamed:@"icon_n_02@2x"];
        
        workNmaelable = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,imageView.size.width, 39.5)];
        workNmaelable.text = @"京";
        workNmaelable.textColor = gycolor;
        workNmaelable.backgroundColor = [UIColor clearColor];
        workNmaelable.font = [UIFont fontWithName:geshi size:17];
        UILabel *lineLble = [[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, W, 0.5)];
        lineLble.backgroundColor = gycoloers;
        [self addSubview:lineLble];
        UILabel *lineLbleup = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
        lineLbleup.backgroundColor = gycoloers;
        [self addSubview:lineLbleup];
        [imageView addSubview:workNmaelable];
        [MenuButton addSubview:titleLable];
        [MenuButton addSubview:imageView];
        [MenuButton addSubview:rightImageView];
        [self addSubview:MenuButton];
    }
    return self;
}
-(void)dropdown{
    [rightLable resignFirstResponder];
    if (showList == YES){//如果下拉框已显示，什么都不做
        showList = NO;
        tv.hidden = YES;
        CGRect sf = self.frame;
        sf.size.height = 30;
        self.frame = sf;
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        [rightImageView setImage:[UIImage imageNamed:@"icon_n_02@2x"]];
    }else {//如果下拉框尚未显示，则进行显示
        [rightImageView setImage:[UIImage imageNamed:@"icon_n_03@2x"]];
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        tv.hidden = NO;
        showList = YES;//显示下拉框
        CGRect frame = tv.frame;
        tv.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        tv.frame = CGRectMake(0, 40, frame.size.width, tabheight);
        [UIView commitAnimations];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    cell.textLabel.textColor = gycolor;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = buttonHighcolor;
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    workNmaelable.text = [tableArray objectAtIndex:[indexPath row]];
//    if (self.worknamesDelegates && [self.worknamesDelegates respondsToSelector:@selector(worknameid:)]) {
//        [self.worknamesDelegates worknameid:indexPath.row];
//    }
//    else
//    {
//        NSLog(@"协议方案未实现");
//    }
    showList = NO;
    tv.hidden = YES;
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    [rightImageView setImage:[UIImage imageNamed:@"icon_n_02@2x"]];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
