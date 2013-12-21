//
//  LabelTextViewCell.m
//  password
//
//  Created by kyle on 12/21/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "LabelTextViewCell.h"

@implementation LabelTextViewCell {
    void (^_completion)();
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setKeyboardCompletion:(void(^)())completion
{
    _completion = completion;
}

@end
