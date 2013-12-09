//
//  MainViewController.m
//  password
//
//  Created by kyle on 13-12-9.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "MainViewController.h"
#import "LockViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    LockViewController *lockView = [[LockViewController alloc] init];
    [self presentViewController:lockView animated:NO completion:nil];
}

- (IBAction)Lock:(id)sender {
    LockViewController *lockView = [[LockViewController alloc] init];
    [self presentViewController:lockView animated:NO completion:nil];
}

@end
