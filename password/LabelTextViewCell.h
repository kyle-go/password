//
//  LabelTextViewCell.h
//  password
//
//  Created by kyle on 12/21/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTextViewPlaceholder.h"

@interface LabelTextViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet KTextViewPlaceholder *placeholderTextView;
- (void)setKeyboardCompletion:(void(^)())completion;

@end
