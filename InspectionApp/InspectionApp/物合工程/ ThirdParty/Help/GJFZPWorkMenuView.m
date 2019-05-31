//
//  GJFZPWorkMenuView.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/27.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZPWorkMenuView.h"

@implementation GJFZPWorkMenuView

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
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor whiteColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [tv setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

        [self addSubview:tv];
        MenuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        [MenuButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width - 30, 30)];
        imageView.image = [UIImage imageNamed:@"mlgj-2x51"];
        
        rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 30, 0, 30, 30)];
        rightImageView.image = [UIImage imageNamed:@"icon_n_02@2x"];
        
        workNmaelable = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,imageView.size.width - 30, 30)];
        workNmaelable.text = @"选择维修人员";
        workNmaelable.textColor = gycoloer;
        workNmaelable.backgroundColor = [UIColor clearColor];
        [imageView addSubview:workNmaelable];
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
        tv.frame = frame;
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
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
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
    if (self.worknameDelegates && [self.worknameDelegates respondsToSelector:@selector(worknameid:)]) {
        [self.worknameDelegates worknameid:indexPath.row];
    }
    else
    {
        NSLog(@"协议方案未实现");
    }
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
