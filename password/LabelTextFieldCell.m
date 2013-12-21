//
//  LabelTextFieldCell.m
//  password
//
//  Created by kyle on 12/16/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "LabelTextFieldCell.h"

@implementation LabelTextFieldCell {
    void (^_completion)();
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _completion = ^{};
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)keyboardNext:(id)sender {
    _completion();
}

- (void)setKeyboardCompletion:(void(^)())completion
{
    _completion = completion;
}

@end
