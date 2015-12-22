//
//  ViewController.h
//  TableViewSample
//
//  Created by ELA on 16/12/15.
//  Copyright © 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "notifyDbutil.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tableView;
    NSArray *tableData;
    
    
    
}

@property (strong, nonatomic) notifyDbutil *notifydbutil;
@property (nonatomic) NSInteger NotifylocalId;
@property (strong, nonatomic) NSMutableArray *notifyList;

@property (strong, nonatomic) UIView *content;
@property (nonatomic)UIView *localcontent;
@property (nonatomic)UITextField *hourinput;
@property (nonatomic)UITextField *mininput;
@property (nonatomic)UITextView *msginput;
-(void) settime;
-(void) savedb:(NSString *)message;

@end

