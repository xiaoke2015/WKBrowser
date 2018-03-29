//
//  RecordDataBase.m
//  WKBrowser
//
//  Created by 李加建 on 2017/11/7.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RecordDataBase.h"

#import <FMDatabase.h>

@interface RecordDataBase ()

@property (nonatomic)FMDatabase *dataBase;

@end

@implementation RecordDataBase




- (void)openDataBase {
    
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"record.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        
        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_bill (id integer PRIMARY KEY AUTOINCREMENT, url VARCHAR(200) NOT NULL, title VARCHAR(60) NOT NULL , date VARCHAR(20) NOT NULL ,iscoll VARCHAR(20) NOT NULL );";
        //4.创表
        BOOL result = [db executeUpdate:sql];
        if (result)
        {
            NSLog(@"创建表成功");
        }
        else {
            NSLog(@"fails");
        }
    }
    
    self.dataBase = db;
}



- (void)insertTableWithTitle:(NSString*)title
                         url:(NSString*)url

{
    
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSDate *date = [NSDate date];
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr = [dateFormatter2 stringFromDate:date];
   
    
    BOOL result1 = [db executeUpdate:@"DELETE FROM t_bill WHERE url = ? AND title = ?;",url,title];
    
    if (result1)
    {
        NSLog(@"删除成功");
    }
    else {
        NSLog(@"删除fails");
    }
    
    NSString * iscoll = @"0";
    
    //    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_bill (date, day ,type, price ,pay) VALUES (%@,%@,%@,%@,%@);",dateStr,dayStr,type,price,pay];
    
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result = [db executeUpdate:@"INSERT INTO t_bill (url, title ,date ,iscoll) VALUES (?,?,?,?);",url,title,dateStr,iscoll];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
}



- (void)closeDataBase {
    
    
    [self.dataBase close];
}


- (void)queryLineData:(MDArrayResultBlock)resultBlock
                 {
    
    //    NSString *mouth = @"2017年10月%";
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
                     
    NSString *iscoll = @"0";
    
    //查询整个表
    FMResultSet *resultSet = [db executeQuery:@"select * from t_bill  WHERE iscoll = ? order by date DESC ;",iscoll];
    
    //遍历结果集合
 
    
    NSMutableArray * dataSource = [NSMutableArray array];
    
    while ([resultSet  next])
        
    {
        
        RecordModel *model = [RecordModel new];
        
        model.Id = [resultSet objectForColumn:@"id"];
        model.title = [resultSet objectForColumn:@"title"];
        model.date = [resultSet objectForColumn:@"date"];
        model.url = [resultSet objectForColumn:@"url"];
        
        [dataSource addObject:model];
        
    }
    
    NSLog(@"dataSource = %@",dataSource);
    
    
    [self closeDataBase];
    
    resultBlock(dataSource,nil);
  
    
}


- (void)delWithBillId:(NSString*)Id {
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    BOOL result = [db executeUpdate:@"DELETE FROM t_bill WHERE id = ?;",Id];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
    
}



- (void)delAll {
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSString *iscoll = @"0";
    
    BOOL result = [db executeUpdate:@"DELETE FROM t_bill WHERE iscoll = ? ;",iscoll];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
    
}


- (void)delCollAll {
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSString *iscoll = @"1";
    
    BOOL result = [db executeUpdate:@"DELETE FROM t_bill WHERE iscoll = ? ;",iscoll];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
    
}



- (void)addColl:(RecordModel *)model {
    
    
    NSString *Id = model.Id ;
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSString *iscoll = @"1";
    
    BOOL result = [db executeUpdate:@"UPDATE t_bill SET iscoll=? WHERE id = ?;",iscoll,Id];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
}


- (void)delColl:(RecordModel *)model {
    
    
    NSString *Id = model.Id ;
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSString *iscoll = @"0";
    
    BOOL result = [db executeUpdate:@"UPDATE t_bill SET iscoll = ? WHERE id = ?;",iscoll,Id];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
}



#pragma mark -
#pragma mark 收藏列表

- (void)queryCollData:(MDArrayResultBlock)resultBlock
{
    
    //    NSString *mouth = @"2017年10月%";
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSString *iscoll = @"1";
    
    //查询整个表
    FMResultSet *resultSet = [db executeQuery:@"select * from t_bill  WHERE iscoll = ? order by date DESC ;",iscoll];
    
    //遍历结果集合
    
    
    NSMutableArray * dataSource = [NSMutableArray array];
    
    while ([resultSet  next])
        
    {
        
        RecordModel *model = [RecordModel new];
        
        model.Id = [resultSet objectForColumn:@"id"];
        model.title = [resultSet objectForColumn:@"title"];
        model.date = [resultSet objectForColumn:@"date"];
        model.url = [resultSet objectForColumn:@"url"];
        
        [dataSource addObject:model];
        
    }
    
    NSLog(@"dataSource = %@",dataSource);
    
    
    [self closeDataBase];
    
    resultBlock(dataSource,nil);
    
    
}



#pragma mark -
#pragma mark 收藏

- (void)insertCollWithTitle:(NSString*)title
                         url:(NSString*)url

{
    
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr = [dateFormatter2 stringFromDate:date];
    
    
    BOOL result1 = [db executeUpdate:@"DELETE FROM t_bill WHERE url = ? AND title = ?;",url,title];
    
    if (result1)
    {
        NSLog(@"删除成功");
    }
    else {
        NSLog(@"删除fails");
    }
    
    NSString * iscoll = @"1";
    
    //    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_bill (date, day ,type, price ,pay) VALUES (%@,%@,%@,%@,%@);",dateStr,dayStr,type,price,pay];
    
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result = [db executeUpdate:@"INSERT INTO t_bill (url, title ,date ,iscoll) VALUES (?,?,?,?);",url,title,dateStr,iscoll];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
}




@end
