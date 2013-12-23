//
//  RemarkTextViewController.m
//  password
//
//  Created by kyle on 13-12-23.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "RemarkTextViewController.h"
#import "KTextViewPlaceholder.h"

@interface RemarkTextViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet KTextViewPlaceholder *textView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation RemarkTextViewController

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
    self.title = @"文本备注";
    
    self.textView.placeholder = @"添加文本备注";
    self.textView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.8];
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.textView.layer.borderWidth = 1.0;
    self.textView.layer.cornerRadius = 6.0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonSystemItemAction target:self action:@selector(save)];
    
    //self.navigationItem.leftBarButtonItem
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ UITextViewDelegate ------------
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger leftWord = 240 - [textView.text length];
    if (leftWord >= 0) {
        self.textLabel.textColor = [UIColor darkGrayColor];
    } else {
        self.textLabel.textColor = [UIColor redColor];
    }
    
    self.textLabel.text = [[NSString alloc] initWithFormat:@"%ld", (long)leftWord];
    [self.textLabel sizeToFit];
}

- (void)save
{
    if (self.textView.text.length == 0) {
        return;
    }
    
    if ([self.textView.text length] > 240) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"太长了!不能超过240个字哦！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [self.delegate remarkText:self.textView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
