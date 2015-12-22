//
//  SecondViewController.m
//  samplewithout
//
//  Created by ELA on 27/11/15.
//  Copyright © 2015 test. All rights reserved.
//

#import "SecondViewController.h"
#import "AppMacros.h"

@interface SecondViewController ()


@property(nonatomic) int count;

@end

@implementation SecondViewController


- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    float red,green,blue;
    red=arc4random_uniform(256)/255.0;
    green=arc4random_uniform(256)/255.0;
    blue=arc4random_uniform(256)/255.0;
    UIColor *color =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.view.backgroundColor = color;
    
    [self.view endEditing:YES];
}


-(void) buttonClicked:(UIButton*)sender
{
    NSString *message = [self getValueFrom];
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Start Playing"
                                                                               message: message
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             self.count=0;
                            
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:5
                                                                                 target:self
                                                                               selector:@selector(calculateNextNumber)
                                                                               userInfo:nil
                                                                                repeats:YES];  //sample sheduled task code
//                             self.backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//                                 NSLog(@"Background handler called. Not running background tasks anymore.");
//                                 [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTask];
//                                 self.backgroundTask = UIBackgroundTaskInvalid;
//                             }];
                             
                             
                         }];
    
    [myAlertController addAction: ok];
    
    [self presentViewController:myAlertController animated:YES completion:nil];
    
}

-(void)calculateNextNumber{
    @autoreleasepool {
        if(self.count <15)
        {
        // this will be executed no matter app is in foreground or background
        NSLog(@"Thread is %d ",self.count++);
            
        }
        else
        {
            NSLog(@"Thread stopped at %d ",self.count);
            [self.updateTimer invalidate];
            self.updateTimer = nil;
        }
        
    }
}

-(NSString *) getValueFrom
{
    NSString *val=@"Yooohoooo!!!";
    
    return val;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    UIColor *color =[UIColor colorWithRed:204/255.0 green:102.0/255.0 blue:255.0/255.0 alpha:1];
    self.view.backgroundColor = color;
    self.title = @"Second Controller";
    
    UILabel *welcomeNote = [[UILabel alloc]initWithFrame:CGRectMake(MarginLeft,MarginTop, self.view.frame.size.width-(2*MarginLeft), EleWidth)];
    
    NSString *greetings =[NSString stringWithFormat:@" Welcome , %@",self.Username];
    [welcomeNote setText:greetings];
    UIColor *customColor=[UIColor colorWithRed:128 green:232 blue:112 alpha:2];      // setting custom color to the  Label
    [welcomeNote setTextColor:customColor];
    [self.view addSubview:welcomeNote];
    
    UIButton *buttonLetsPlay= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonLetsPlay addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [buttonLetsPlay setFrame:CGRectMake(MarginLeft, welcomeNote.frame.origin.y+EleSpacing, self.view.frame.size.width-(2*MarginLeft),EleWidth)];
     buttonLetsPlay.backgroundColor =[UIColor whiteColor];
    [buttonLetsPlay setTitle:@"Start Playing" forState:UIControlStateNormal];
    [buttonLetsPlay setExclusiveTouch:YES];
    
    
    UIGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapper];
    [self.view addSubview:buttonLetsPlay];
    
                            
}
@end
