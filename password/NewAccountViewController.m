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
#import "LabelTextViewCell.h"

@interface NewAccountViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewAccountViewController {
    __weak UITextField *_name;
    __weak UITextField *_account;
    __weak UITextField *_password;
    __weak UITextField *_website;
    __weak UITextView *_remark;
}

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
    
    UIColor *color = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.8];
    self.tableView.backgroundColor = color;
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
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //section 1
    if (indexPath.section == 1) {
        return 60.0;
    }
    
    //section 0
    if (indexPath.row == 0) {
        return 75.0;
    }
    return 36.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //附加信息
    if (indexPath.section == 1) {
        NSString *cellIdentify = @"LabelTextViewCellIdentify";
        LabelTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"LabelTextViewCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        _remark = cell.placeholderTextView;
        cell.placeholderTextView.delegate = self;
        cell.placeholderTextView.placeholder = @"备注信息";
        return cell;
    }
    
    //头像，名称
    if (indexPath.row == 0) {
        NSString *cellIdentify = @"ImageTextFieldCellIdentify";
        ImageTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ImageTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        [cell setKeyboardCompletion:^{[_account becomeFirstResponder];}];
        return cell;
    }
    //账号
    //密码
    //网址
    if (indexPath.row >= 1 && indexPath.row <= 3) {
        NSString *cellIdentify = @"LabelTextFieldCellIdentify";
        LabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"LabelTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        if (indexPath.row == 1) {
            _account = cell.contentTextField;
            cell.titleLabel.text = @"账号:";
            cell.contentTextField.placeholder = @"账号";
            [cell setKeyboardCompletion:^{[_password becomeFirstResponder];}];
        } else if (indexPath.row == 2) {
            _password = cell.contentTextField;
            cell.titleLabel.text = @"密码:";
            cell.contentTextField.placeholder = @"密码";
            [cell setKeyboardCompletion:^{[_website becomeFirstResponder];}];
        } else if (indexPath.row == 3) {
            _website = cell.contentTextField;
            cell.titleLabel.text = @"网址:";
            cell.contentTextField.placeholder = @"网址";
            cell.contentTextField.text = @"http://";
            [cell setKeyboardCompletion:^{[_remark becomeFirstResponder];}];
        }
        return cell;
    }
    
    return nil;
}

#pragma remark --- UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
