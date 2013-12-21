//
//  SettingViewController.m
//  password
//
//  Created by kyle on 12/16/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController {
    __weak UISwitch *_passwordProtect;
    __weak UISwitch *_dataProtect;
    BOOL _isPasswordProjectAlertView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = globalBackgroundColor;
    self.tableView.backgroundColor = globalBackgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------- table view delegate -------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 4;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = @"commonTableViewCellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(258, 6, 100, 40)];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"本地口令";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:sw];
                _passwordProtect = sw;
                [sw addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            case 1:
                cell.textLabel.text = @"数据保护";
                [cell.contentView addSubview:sw];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                _dataProtect = sw;
                [sw addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
                break;
            case 2:
                cell.textLabel.text = @"修改密码";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"去评分";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 1:
                cell.textLabel.text = @"分享给小伙伴";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 2:
                cell.textLabel.text = @"建议反馈";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 3:
                cell.textLabel.text = @"关于";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ss" message:@"tt" delegate:nil cancelButtonTitle:@"fdfdf" otherButtonTitles:nil];
//    [alert show];
    return nil;
}

- (void)switchChanged:(id)sender
{
    if (sender == _passwordProtect) {
        if (_passwordProtect.on == NO) {
            _isPasswordProjectAlertView = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定取消本地口令吗?唤醒应用不再需要密码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
        }
    } else if(sender == _dataProtect) {
        if (_dataProtect.on == YES) {
            _isPasswordProjectAlertView = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定开启数据保护功能吗?本地口令连续认证错误10次销毁全部数据!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_isPasswordProjectAlertView) {
        switch (buttonIndex) {
                //确定
            case 0:
                break;
                //取消
            case 1:
                _passwordProtect.on = YES;
                break;
            default:
                break;
        }
    } else {
        switch (buttonIndex) {
                //确定
            case 0:
                break;
                //取消
            case 1:
                _dataProtect.on = NO;
                break;
            default:
                break;
        }
    }
}

@end
