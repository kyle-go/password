//
//  KTextViewPlaceholder.h
//  KTextViewPlaceholder
//
//  Created by kyle on 13-12-6.
//  Copyright (c) 2013 kyle. All rights reserved.
//
//  https://github.com/kylescript/KTextViewPlaceholder
//

#import <UIKit/UIKit.h>

@interface KTextViewPlaceholder : UITextView

@property (nonatomic, strong) NSString  *placeholder;       //no placehoder for default.
@property (nonatomic, strong) UIColor   *placeholderColor;  //lightGrayColor for default.
@property (nonatomic, assign) CGPoint   placeholderPos;     //CGPoint(6,8) for default.

@end
