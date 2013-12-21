//
//  Storage.m
//  password
//
//  Created by kyle on 12/22/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "Storage.h"
#import "FMDatabase.h"

@implementation Storage {
     FMDatabase *_db;
}

+ (instancetype)Instance
{
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{instance = self.new;});
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        //初始化数据库
        NSString *dbFile = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"storage.db"];
        dbFile = [dbFile stringByAppendingString:DATABASE_VERSION];
        
        _db = [FMDatabase databaseWithPath:dbFile];
        if (!_db) {
            NSLog(@"FMDatabase databaseWithPath failed.");
            abort();
        }
        if (![_db open]) {
            NSLog(@"FMDatabase open failed.");
            abort();
        }
    }
    
    return self;
}

@end
