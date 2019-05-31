//
//  GJFZPPulldownMenuView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZPPulldownMenuView.h"

@implementation GJFZPPulldownMenuView
@synthesize tv,tableArray,MenuButton,leftLable,rightLable;

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height < 200) {
        frameHeight = 200;
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
        MenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        MenuButton.backgroundColor = [UIColor whiteColor];
        [MenuButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        leftLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 80, 20)];
        leftLable.textColor = gycoloer;
        leftLable.backgroundColor = [UIColor clearColor];
        rightLable = [[UILabel alloc]initWithFrame:CGRectMake(90,10, MenuButton.size.width - leftLable.size.width - 30, 20)];
        rightLable.backgroundColor = [UIColor clearColor];
        rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MenuButton.size.width - 30, 14, 12, 10)];
        rightImageView.backgroundColor = [UIColor clearColor];
        rightImageView.image = [UIImage imageNamed:@"mlgj-2x60"];
        [MenuButton addSubview:rightImageView];
        [MenuButton addSubview:leftLable];
        [MenuButton addSubview:rightLable];
        [self addSubview:MenuButton];
    }
    return self;
}
-(void)dropdown{
    [rightLable resignFirstResponder];
    if (showList == YES){//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        [rightImageView setImage:[UIImage imageNamed:@"mlgj-2x61"]];
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        tv.hidden = NO;
        showList = YES;//显示下拉框
        CGRect frame = tv.frame;
        tv.frame = frame;
        frame.size.height = tabheight;
        NSLog(@"%f",tabheight);
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
    rightLable.text = [tableArray objectAtIndex:[indexPath row]];
    showList = NO;
    tv.hidden = YES;
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    [rightImageView setImage:[UIImage imageNamed:@"mlgj-2x60"]];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
