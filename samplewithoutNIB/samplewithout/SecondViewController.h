//
//  SecondViewController.h
//  samplewithout
//
//  Created by ELA on 27/11/15.
//  Copyright © 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property(nonatomic,strong) NSString * Username;
@property(nonatomic,strong) NSString * Securename;

@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;

@end
