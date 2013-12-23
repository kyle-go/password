//
//  Storage.h
//  password
//
//  Created by kyle on 12/22/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountItem;
@interface Storage : NSObject

+ (instancetype)Instance;

- (void)updateAccountItem:(AccountItem *)item;
- (void)deleteAccountItem:(NSString *)itemId;

@end
