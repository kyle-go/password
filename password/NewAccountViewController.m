//
//  NewAccountViewController.m
//  password
//
//  Created by kyle on 12/16/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "NewAccountViewController.h"
#import "ImageTextFieldCell.h"
#import "LabelTextFieldCell.h"

@interface NewAccountViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新账户";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonSystemItemAction target:self action:@selector(save)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save
{
    
}

#pragma mark --------- table view delegate -------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 75.0;
    }
    return 36.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头像，名称
    if (indexPath.row == 0) {
        NSString *cellIdentify = @"ImageTextFieldCellIdentify";
        ImageTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ImageTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        
        return cell;
    }
    //账号
    //密码
    //网址
    if (indexPath.row >= 1 && indexPath.row <= 2) {
        NSString *cellIdentify = @"LabelTextFieldCellIdentify";
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"LabelTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        
        return cell;
    }
    //附加信息
    
    return nil;
}

@end
