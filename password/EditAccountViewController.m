//
//  NewAccountViewController.m
//  password
//
//  Created by kyle on 12/16/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "EditAccountViewController.h"
#import "ImageTextFieldCell.h"
#import "LabelTextFieldCell.h"
#import "RemarkTextViewController.h"
#import "AccountItem.h"
#import "KUnits.h"

@interface EditAccountViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditAccountViewController {
    __weak UIImageView *_avatar;
    __weak UITextField *_name;
    __weak UITextField *_account;
    __weak UITextField *_password;
    __weak UITextField *_website;
    __weak UITextView *_remark;
    AccountItem * _accountItem;
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
    
    self.tableView.separatorColor = globalBackgroundColor;
    self.tableView.backgroundColor = globalBackgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_accountItem) {
        _accountItem = [[AccountItem alloc] init];
        _accountItem.itemId = [KUnits generateUuidString];
        _accountItem.avatar = [PATH_OF_DOCUMENT stringByAppendingString: [NSString stringWithFormat:@"/Media/%@.png", _accountItem.itemId]];
    }
}

- (void)save
{
    if (_name.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账户名称不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    AccountItem *item = [[AccountItem alloc] init];
    item.itemId = [KUnits generateUuidString];
    item.name = _name.text;
    item.avatar = _accountItem.avatar;
    item.account = _account.text;
    item.password = _password.text;
    item.url = _website.text;
    item.remark = _remark.text;
    item.voices = nil;
    item.pictures = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditAccountItem" object:nil userInfo:@{@"item":item}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --------- table view delegate -------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 3;
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
        return 44.0;
    }
    
    //section 0
    if (indexPath.row == 0) {
        return 75.0;
    }
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 12.0;
    }
    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"备注信息";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //备注信息
    if (indexPath.section == 1) {
        NSString *cellIdentify = @"remarkCellIdentify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"添加文本";
                break;
            case 1:
                cell.textLabel.text = @"添加图片";
                break;
            case 2:
                cell.textLabel.text = @"添加语音";
                break;
            default:
                break;
        }
        return cell;
//        NSString *cellIdentify = @"LabelTextViewCellIdentify";
//        LabelTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//        if (!cell) {
//            [tableView registerNib:[UINib nibWithNibName:@"LabelTextViewCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
//            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//        }
//        _remark = cell.placeholderTextView;
//        cell.placeholderTextView.delegate = self;
//        cell.placeholderTextView.placeholder = @"备注信息";
    }
    
    //头像，名称
    if (indexPath.row == 0) {
        NSString *cellIdentify = @"ImageTextFieldCellIdentify";
        ImageTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ImageTextFieldCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        }
        _name = cell.nameTextField;
        [cell setKeyboardCompletion:^{[_account becomeFirstResponder];}];
        
        //头像点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleAvatarTap:)];
        [cell.avatarImageView addGestureRecognizer:singleTap];
        cell.avatarImageView.userInteractionEnabled = YES;
        _avatar = cell.avatarImageView;
        
        return cell;
    }
    //账号，密码，网址
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //备注信息
    if (indexPath.section == 1) {
        switch (indexPath.row ) {
            case 0:
                //文本
            {
                RemarkTextViewController *remarkView = [[RemarkTextViewController alloc] init];
                 [self.navigationController pushViewController:remarkView animated:YES];
            }
                break;
            case 1:
                //图片
                break;
            case 2:
                //语音
                break;
            default:
                break;
        }
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

//头像点击，换头像
- (void)handleAvatarTap:(UIGestureRecognizer *)gestureRecognizer
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"选择本地图片", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    
    switch (buttonIndex) {
            //拍照
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            //选择本地图片
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            //取消
        case 2:
            break;
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:@"UIImagePickerControllerMediaType"];
    if ([mediaType isEqualToString:@"public.image"]) {
        _avatar.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        //save file
        NSData *imageData = UIImagePNGRepresentation(_avatar.image);
        [imageData writeToFile:_accountItem.avatar atomically:YES];
        
        //dismiss self.
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)EditAccountItem:(AccountItem *)item
{
    _accountItem = item;
}

@end
