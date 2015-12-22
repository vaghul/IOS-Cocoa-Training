#import "notifyDbutil.h"

@implementation notifyDbutil   //Dbhelperclass

@synthesize databasePath;

- (void) initDatabase {
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent:@"test.sqlite"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //the file will not be there when we load the application for the first time
    //so this will create the database table
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
        {
            char *errMsg;
            NSString *sql_stmt = @"CREATE TABLE IF NOT EXISTS MESSAGES (";
            sql_stmt = [sql_stmt stringByAppendingString:@"id INTEGER PRIMARY KEY AUTOINCREMENT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"date TEXT, "];
            sql_stmt = [sql_stmt stringByAppendingString:@"message TEXT) "];
            
            if (sqlite3_exec(mySqliteDB, [sql_stmt UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            else
            {
                NSLog(@"Message table created successfully");
            }
            
            sqlite3_close(mySqliteDB);
            
        } else {
            NSLog(@"Failed to open/create database");
        }
    }
    
}

//save our data
- (BOOL) saveMessage:(NotifyModel *)notify
{
    BOOL success = false;
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
            NSLog(@"New data, Insert Please");
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO MESSAGES (date, message) VALUES (\"%@\", \"%@\")",
                                   notify.date,
                                   notify.message];
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(mySqliteDB, insert_stmt, -1, &statement, NULL);  //should be done always before excuting the query to convert statement to sql understandable format.
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = true;
            }
        
        NSLog(@"insert done %d",success);
        sqlite3_finalize(statement);
        sqlite3_close(mySqliteDB);
        
    }
    
    return success;
}


//get a list of all our employees
- (NSMutableArray *) getNotify
{
    NSMutableArray *notifyList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &mySqliteDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT id, date, message FROM MESSAGES";
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(mySqliteDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NotifyModel *notify = [[NotifyModel alloc] init];
                notify.NotifyID = sqlite3_column_int(statement, 0);
                notify.date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                notify.message = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                [notifyList addObject:notify];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(mySqliteDB);
    }
    
    return notifyList;
}



@end