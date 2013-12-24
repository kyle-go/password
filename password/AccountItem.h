//
//  AccountItem.h
//  password
//
//  Created by kyle on 13-12-23.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *account;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) NSString *voice;
@property (strong, nonatomic) NSArray  *pictures;

@end
