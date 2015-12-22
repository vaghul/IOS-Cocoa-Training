#import <Foundation/Foundation.h>

@interface NotifyModel : NSObject    //ORM based Model to access the store data from and to in the SQLITE Database

@property (nonatomic) NSInteger NotifyID;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *message;


@end