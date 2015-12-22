//
//  ViewController.m
//  TableViewSample
//
//  Created by ELA on 16/12/15.
//  Copyright © 2015 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize notifydbutil,notifyList,NotifylocalId;
@synthesize content,localcontent,hourinput,msginput,mininput;

-(id)init  //overriding init, occurs only once in the application opeand after install
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.notifydbutil = [[notifyDbutil alloc] init];
        [notifydbutil initDatabase];
        
    }
    return self;
}



-(void) settime{[self loadsetnotify];} //set the time for localnotification

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSArray *itemArray = [NSArray arrayWithObjects: @"Set Notification", @"View Notification", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
   
    segmentedControl.frame = CGRectMake(10,self.view.bounds.origin.y+20, 300, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:)
               forControlEvents: UIControlEventValueChanged];  // to add listners for segment selection and to load the apropriate view
    
    content = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, segmentedControl.bounds.origin.y+60, self.view.bounds.size.width, self.view.frame.size.height-(segmentedControl.frame.size.height+30))];
    content.backgroundColor =[UIColor redColor];
    
    [self.view addSubview:segmentedControl];
    [self.view addSubview:content];
    [self loadsetnotify];   //load default segment
    
    
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *) sender  // to close keyboard when clicked in the view
{
    [self.view endEditing:YES];
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        [tableView removeFromSuperview];
        [self loadsetnotify];
        
    }
    else
    {
        [localcontent removeFromSuperview];
        [self loadtableview];
        
    }
}

-(void)loadsetnotify{
    localcontent =[[UIView alloc]initWithFrame:CGRectMake(content.bounds.origin.x,content.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    
    NSLog(@"User's current time in their preference format:%@",currentTime);
    UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(localcontent.bounds.origin.x, localcontent.bounds.origin.y+20, localcontent.bounds.size.width, 20)];
    title.text=@"Set the time for Local notification";
    title.textAlignment=NSTextAlignmentCenter;
    
    UILabel *hourlabel =[[UILabel alloc] initWithFrame:CGRectMake(title.bounds.origin.x+10, title.bounds.origin.y+70, 50, 20)];
    hourlabel.text=@"Hour";
    hourlabel.textAlignment=NSTextAlignmentLeft;
    
    
    hourinput=[[UITextField alloc] initWithFrame:CGRectMake(hourlabel.bounds.origin.x+80, title.bounds.origin.y+70,70, 25)];
    hourinput.borderStyle = UITextBorderStyleRoundedRect;
    hourinput.font = [UIFont systemFontOfSize:15];
    hourinput.autocorrectionType = UITextAutocorrectionTypeNo;
    hourinput.keyboardType = UIKeyboardTypeDefault;
    hourinput.keyboardType = UIKeyboardTypeNumberPad;
    hourinput.clearButtonMode = UITextFieldViewModeWhileEditing;
    hourinput.text=[[currentTime componentsSeparatedByString:@":"] objectAtIndex:0];
    
    UILabel *minlabel =[[UILabel alloc] initWithFrame:CGRectMake(hourinput.bounds.origin.x+10, hourinput.bounds.origin.y+100, 100, 40)];
    minlabel.text=@"Minutes";
    minlabel.textAlignment=NSTextAlignmentLeft;
    
    
    mininput=[[UITextField alloc] initWithFrame:CGRectMake(minlabel.bounds.origin.x+80, minlabel.bounds.origin.y+105,70, 25)];
    mininput.borderStyle = UITextBorderStyleRoundedRect;
    mininput.font = [UIFont systemFontOfSize:15];
    mininput.autocorrectionType = UITextAutocorrectionTypeNo;
    mininput.keyboardType = UIKeyboardTypeNumberPad;
    mininput.returnKeyType = UIReturnKeyDone;
    mininput.clearButtonMode = UITextFieldViewModeWhileEditing;
    NSString *val=[[currentTime componentsSeparatedByString:@" "] objectAtIndex:0];
    mininput.text=[[val componentsSeparatedByString:@":"] objectAtIndex:1];
    
    
    UILabel *msglabel =[[UILabel alloc] initWithFrame:CGRectMake(mininput.bounds.origin.x, mininput.bounds.origin.y+150, 200, 40)];
    msglabel.text=@"Type your message Here";
    msglabel.textAlignment=NSTextAlignmentCenter;
    
    
    msginput=[[UITextView alloc] initWithFrame:CGRectMake(msglabel.bounds.origin.x+20, msglabel.bounds.origin.y+190,content.bounds.size.width-40, 100)];
    
    msginput.font = [UIFont systemFontOfSize:15];
    msginput.autocorrectionType = UITextAutocorrectionTypeNo;
    msginput.keyboardType = UIKeyboardTypeDefault;
    msginput.returnKeyType = UIReturnKeyDone;
    msginput.editable=YES;
    
    
    UIButton *Setbutton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Setbutton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [Setbutton setFrame:CGRectMake(msginput.bounds.origin.x+100, msginput.bounds.origin.y+310, 100, 40)];
    Setbutton.backgroundColor =[UIColor whiteColor];
    //[but setBackgroundColor:[UIColor whiteColor]];
    [Setbutton setTitle:@"Notify ME" forState:UIControlStateNormal];
    [Setbutton setExclusiveTouch:YES];
    
    UIGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    
    [localcontent addSubview:title];
    [localcontent addSubview:hourlabel];
    [localcontent addSubview:hourinput];
    [localcontent addSubview:minlabel];
    [localcontent addSubview:mininput];
    [localcontent addSubview:msglabel];
    [localcontent addSubview:msginput];
    [localcontent addGestureRecognizer:tapper];
    [localcontent addSubview:Setbutton];                //add all the elements to a local view to manage it more efficient
    [content addSubview:localcontent]; // add the localview to The main View.
}
-(void) buttonClicked:(UIButton*)sender{[self startpushnotify];}

-(void) savedb:(NSString *) message
{
    NotifyModel *notify=[[NotifyModel alloc]init];
    notify.NotifyID=self.NotifylocalId;
    notify.date=@"test";
    notify.message=message;
    [notifydbutil saveMessage:notify];
    NSLog(@"save sent");
    
}
-(void) startpushnotify
{
    NSString *hourstring =hourinput.text;
    NSString *minutesstring =mininput.text;
    NSInteger hour =[hourstring integerValue];
    NSInteger minutes=[minutesstring integerValue];
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components1 day];
    NSInteger month = [components1 month];
    NSInteger year = [components1 year];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    [components setMinute:minutes];
    [components setHour:hour];
    NSDate *myNewDate = [calendar dateFromComponents:components];
    [self scheduleNotificationForDate:myNewDate];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucess"
                                                    message:@"Notification has been set"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)scheduleNotificationForDate:(NSDate *)date
{
    
    // Here we cancel all previously scheduled notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = date;
    NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = msginput.text;
    localNotification.alertAction = NSLocalizedString(@"View details", nil);
    
    /* Here we set notification sound and badge on the app's icon "-1"
     means that number indicator on the badge will be decreased by one
     - so there will be no badge on the icon */
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    long  badge= [UIApplication sharedApplication].applicationIconBadgeNumber;
    NSLog(@"badge number is %ld",badge);
    
    localNotification.applicationIconBadgeNumber = badge+1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)loadtableview
{
    
    notifyList=[notifydbutil getNotify];
    
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(content.bounds.origin.x,content.bounds.origin.y,self.content.bounds.size.width,self.content.bounds.size.height)];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:@"Cell"];
    [tableView reloadData];
    [content addSubview:tableView];
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor blackColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.textLabel.text=@"Notification History";
    // Another way to set the background color
    // header.contentView.backgroundColor = [UIColor blackColor];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notifyList count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //alternative light and dark colour for cell
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NotifyModel *notify = [[NotifyModel alloc] init];
    notify = [self.notifyList objectAtIndex:indexPath.row];
    NSLog(@"name at %ld is %@",(long)indexPath.row,notify.message);
    cell.textLabel.text=notify.message;
    cell.textLabel.lineBreakMode=YES;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"book %@, indexPath %@",[tableData objectAtIndex:indexPath.row],indexPath);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // to deselect the row after click
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //to provide header space
    return 30.0;
}


@end
