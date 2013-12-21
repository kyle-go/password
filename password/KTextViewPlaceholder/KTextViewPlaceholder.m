//
//  KTextViewPlaceholder.m
//  KTextViewPlaceholder
//
//  Created by kyle on 13-12-6.
//  Copyright (c) 2013 kyle. All rights reserved.
//
//  https://github.com/kylescript/KTextViewPlaceholder
//

#import "KTextViewPlaceholder.h"

@implementation KTextViewPlaceholder {
    UILabel *_placehoderLabel;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _placehoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 8, 1, 1)];
        _placehoderLabel.backgroundColor = [UIColor clearColor];
        _placehoderLabel.textColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - Getters and Setters
- (void)setPlaceholder:(NSString *)placeholder
{
    _placehoderLabel.text = placeholder;
    _placehoderLabel.font = self.font;
    [_placehoderLabel sizeToFit];
    
    if (self.text.length == 0) {
       [self addSubview:_placehoderLabel];
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placehoderLabel.textColor = placeholderColor;
}

- (void)setPlaceholderPos:(CGPoint)placeholderPos
{
    CGRect frame = _placehoderLabel.frame;
    frame.origin = placeholderPos;
    _placehoderLabel.frame = frame;
}

- (void) setText:(NSString *)text {
    [super setText:text];
    [self textDidChange:nil];
}

#pragma mark -
#pragma mark Notifications
- (void)textDidChange:(NSNotification *)notification
{
    if ([self.text length]) {
        [_placehoderLabel removeFromSuperview];
    } else {
        [self addSubview:_placehoderLabel];
    }
}

@end
