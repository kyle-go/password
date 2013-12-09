//
//  LockViewController.m
//  password
//
//  Created by kyle on 13-12-9.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "LockViewController.h"

@interface LockViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation LockViewController {
    SPLockScreen *lockScreen;
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
    [self.view sendSubviewToBack:self.backgroundImage];
    
    lockScreen = [[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    CGPoint center = self.view.center;
    center.y += 100;
    lockScreen.center = center;
	lockScreen.delegate = self;
	lockScreen.backgroundColor = [UIColor clearColor];
	[self.view addSubview:lockScreen];
    [self.view bringSubviewToFront:lockScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma comment --- LockScreenDelegate -----
- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
    NSLog(@"Lock is %ld...", [patternNumber longValue]);
}

@end
