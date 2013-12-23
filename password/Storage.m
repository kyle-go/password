//
//  Storage.m
//  password
//
//  Created by kyle on 12/22/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "Storage.h"
#import "FMDatabase.h"
#import "AccountItem.h"

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
        //创建media文件夹
        NSString *mediaPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"Media"];
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:mediaPath withIntermediateDirectories:NO attributes:nil error:&error];
        
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
        
        //create AccountItem table
        NSString * sql = @"CREATE TABLE IF NOT EXISTS 'AccountItem' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, 'itemId' VARCHAR(40), 'name' VARCHAR(64), 'avatar' VARCHAR(260), 'account' VARCHAR(64), 'password' VARCHAR(32), 'url' VARCHAR(260), 'remark' VARCHAR(260), 'voices' VARCHAR(260), 'pictures' VARCHAR(260))";
        if (![_db executeUpdate:sql]) {
            debugLog(@"create Item table failed. error=%@", [_db lastError]);
        } else {
            debugLog(@"create Item table successfully.");
        }
    }
    
    return self;
}

- (NSArray *)getAccountItems
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSString *sql = @"SELECT * FROM AccountItem";
    FMResultSet* fs = [_db executeQuery:sql];
    while ([fs next]) {
        AccountItem *item = [[AccountItem alloc] init];
        item.itemId = [fs stringForColumn:@"itemId"];
        //item.avatar = [fs stringForColumn:<#(NSString *)#>]
    }
    return array;
}

- (void)deleteAccountItem:(NSString *)itemId
{
    NSString *sql = [[NSString alloc] initWithFormat:@"DELETE FROM AccountItem WHERE itemId = '%@'", itemId];
    BOOL res = [_db executeUpdate:sql];
    if (!res) {
        debugLog(@"deleteAccountItem failed.error=%@", [_db lastError]);
    } else {
        debugLog(@"deleteAccountItem successfully.");
    }
}

- (void)updateAccountItem:(AccountItem *)item
{
    //delete old item
    [self deleteAccountItem:item.itemId];
    
    NSString *sql = @"INSERT INTO AccountItem (itemId, name, avatar, account, password, url, remark, voices, pictures) values (?,?,?,?,?,?,?,?,?)";
    BOOL res = [_db executeUpdate:sql,
                item.itemId,
                item.name,
                item.avatar,
                item.account,
                item.password,
                item.url,
                item.remark,
                item.voices,
                item.pictures];
    
    if (!res) {
        debugLog(@"updateAccountItem failed.error=%@", [_db lastError]);
    } else {
        debugLog(@"updateAccountItem successfully.");
    }
}

@end
