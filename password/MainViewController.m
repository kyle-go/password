//
//  MainViewController.m
//  password
//
//  Created by kyle on 13-12-9.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "MainViewController.h"
#import "LockViewController.h"
#import "SettingViewController.h"
#import "NewAccountViewController.h"
#import "AccountSummaryCell.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPasswordView) name:@"SHOW_PASSWORD_VIEW" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"所有账户(0)";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonSystemItemAction target:self action:@selector(settingView)];
    
    self.tableView.backgroundColor = globalBackgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPasswordView
{
    LockViewController *lockView = [[LockViewController alloc] init];
    [self presentViewController:lockView animated:NO completion:nil];
}

- (void)addAccount
{
    NewAccountViewController *accountView = [[NewAccountViewController alloc] init];
    [self.navigationController pushViewController:accountView animated:YES];
}

- (void)settingView
{
    SettingViewController *settingView = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingView animated:YES];
}

#pragma mark --------- table view delegate -------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = @"tableViewCellIdentify";
    AccountSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"AccountSummaryCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    }
    return cell;
}

@end
