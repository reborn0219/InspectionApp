//
//  GJFZPPullDownMenu.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZPPullDownMenu.h"

@interface GJFZPPullDownMenu()
{
    BOOL showList;
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}
@end

@implementation GJFZPPullDownMenu
@synthesize dataArray;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createdUI];
    }
    return self;
}

-(void)createdUI
{
    self.Cellbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    self.Cellbutton.backgroundColor = [UIColor whiteColor];
    [self.Cellbutton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
    self.leftLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 80, 20)];
    self.leftLable.textColor = gycoloer;
    self.leftLable.backgroundColor = [UIColor clearColor];
    self.rightLable = [[UILabel alloc]initWithFrame:CGRectMake(90,10, self.Cellbutton.size.width - self.leftLable.size.width - 30, 20)];
    self.rightLable.backgroundColor = [UIColor clearColor];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.Cellbutton.size.width - 30, 14, 12, 10)];
    self.rightImageView.backgroundColor = [UIColor clearColor];
    self.rightImageView.image = [UIImage imageNamed:@"mlgj-2x60"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.Cellbutton.size.height, self.frame.size.width, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.hidden = YES;
    [self.Cellbutton addSubview:self.rightImageView];
    [self.Cellbutton addSubview:self.leftLable];
    [self.Cellbutton addSubview:self.rightLable];
    [self addSubview:self.tableView];
    [self addSubview:self.Cellbutton];
}
-(void)dropdown{
    [self.rightLable resignFirstResponder];
    if (showList == YES){//如果下拉框已显示
        showList = NO;
        self.tableView.hidden = YES;
        CGRect sf = self.frame;
        sf.size.height = 30;
        self.frame = sf;
        CGRect frame = self.tableView.frame;
        frame.size.height = 0;
        self.tableView.frame = frame;
        [self.rightImageView setImage:[UIImage imageNamed:@"mlgj-2x60"]];
        return;
    }else {//如果下拉框尚未显示，则进行显示
        [self.rightImageView setImage:[UIImage imageNamed:@"mlgj-2x61"]];
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        self.tableView.hidden = NO;
        showList = YES;//显示下拉框
        CGRect frame = self.tableView.frame;
        //frame.size.height = 0;
        self.tableView.frame = frame;
        frame.size.height = tabheight;
        NSLog(@"%f",tabheight);
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        self.tableView.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = buttonHighcolor;
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.rightLable.text = [self.dataArray objectAtIndex:[indexPath row]];
    showList = NO;
    self.tableView.hidden = YES;
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = self.tableView.frame;
    frame.size.height = 0;
    self.tableView.frame = frame;
    [self.rightImageView setImage:[UIImage imageNamed:@"mlgj-2x60"]];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//-(NSArray *)dataArray
//{
//    if (self.dataArray == nil) {
//        self.dataArray = [NSArray array];
//    }
//    return _dataArray;
//}

@end
