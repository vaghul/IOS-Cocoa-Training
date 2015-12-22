#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "NotifyModel.h"

@interface notifyDbutil : NSObject {
    sqlite3 *mySqliteDB;
}

@property (nonatomic, strong) NSString *databasePath;

- (void) initDatabase;
- (BOOL) saveMessage:(NotifyModel *)notify;
- (NSMutableArray *) getNotify;

@end
