//
//  RemarkTextViewController.h
//  password
//
//  Created by kyle on 13-12-23.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemarkTextViewDelegate <NSObject>

- (void)remarkText:(NSString *)text;

@end

@interface RemarkTextViewController : UIViewController

@property (nonatomic, weak) id <RemarkTextViewDelegate> delegate;
@property (nonatomic, strong) NSString *text;

@end
