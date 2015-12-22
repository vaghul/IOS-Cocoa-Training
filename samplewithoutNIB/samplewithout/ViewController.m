//
//  ViewController.m
//  samplewithout
//
//  Created by ELA on 26/11/15.
//  Copyright © 2015 test. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "AppMacros.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    UITextField * textFieldPassword ;
    
}
@property (nonatomic,strong)UITextField *textFieldUserName;

@end




@implementation ViewController

@synthesize textFieldUserName;




-(void) buttonClicked:(UIButton*)sender
{
    if([self canNavigate:self.textFieldUserName.text withPassword:textFieldPassword.text])  // Checking for name and password isempty
    {
        NSLog(@"Navigating to second view");
        SecondViewController *next =[[SecondViewController alloc] init];
        next.Username=self.textFieldUserName.text;
        next.Securename =textFieldPassword.text;
        //[self presentViewController:next animated:YES completion:nil];  //way 1 to navigate
        [self.navigationController pushViewController:next animated:YES];
    }
    else
    {
        UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Missing Details"
                                                                                   message: @""
                                                                            preferredStyle:UIAlertControllerStyleActionSheet];  //Create a UIAlertcontroller that can be used to show alertmessages
        
        
        // Create a UIAlertAction that can be added to the alert
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here, eg dismiss the alertwindow
                                 [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        //Add the UIAlertAction ok that we just created to our AlertController
        [myAlertController addAction: ok];
        
        //Present the alert to the user
        [self presentViewController:myAlertController animated:YES completion:nil];

        
    }
}

-(BOOL)canNavigate:(NSString *) username withPassword:(NSString *) password
{

    BOOL Flag=NO;
    if((username.length>0)&&(password.length>0))
       Flag=YES;
       return Flag;
}

-(void)Ontyping:(id)sender {NSLog(@"Char %@",((UITextField *)sender).text);}  // To detect all char while typing

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
    {
        float red,green,blue;
        red=arc4random_uniform(256)/255.0;   //get random number in range 0-256
        green=arc4random_uniform(256)/255.0;
        blue=arc4random_uniform(256)/255.0;
        UIColor *color =[UIColor colorWithRed:red green:green blue:blue alpha:1];
        self.view.backgroundColor = color;
        [self.view endEditing:YES];
    }                                   // changing background colour on click on the screen

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; // close keyboard on RETURN key press
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{NSLog(@"Editing began");}  //detect on editing started on TextField


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    UIColor *color =[UIColor colorWithRed:204/255.0 green:102.0/255.0 blue:255.0/255.0 alpha:1];
    self.view.backgroundColor = color;
    self.title = @"First Controller";  //title for Navigation Controller, while be displayed on the screen top (wont be displayed for normal viewcontroller)
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(MarginLeft, MarginTop, self.view.frame.size.width-(2*MarginLeft) , EleWidth)];
    title.text=@"GAME";
    title.font=[UIFont systemFontOfSize:30 weight:10];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];

    
    textFieldUserName= [[UITextField alloc] initWithFrame:CGRectMake(MarginLeft, title.frame.origin.y+EleSpacing, self.view.frame.size.width-(2*MarginLeft), EleWidth)];
    textFieldUserName.borderStyle = UITextBorderStyleRoundedRect;
    textFieldUserName.font = [UIFont systemFontOfSize:15];
    textFieldUserName.placeholder = @"username";
    textFieldUserName.autocorrectionType = UITextAutocorrectionTypeNo;
    textFieldUserName.keyboardType = UIKeyboardTypeDefault;  //can specify the type of keyboard(number,telephone,normail,email)
    textFieldUserName.returnKeyType = UIReturnKeyDone;
    textFieldUserName.clearButtonMode = UITextFieldViewModeWhileEditing;  //round close button on the right corner of text field to clear all the content of the fields
    textFieldUserName.delegate=self;
    //[_textFieldUserName addTarget:self action:@selector(Ontyping:) forControlEvents:UIControlEventEditingChanged];
    // Above line to print out all the char entered in the textview on typing
   
    textFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(MarginLeft,textFieldUserName.frame.origin.y+EleSpacing ,self.view.frame.size.width-(2*MarginLeft), EleWidth)];
    textFieldPassword.borderStyle = UITextBorderStyleRoundedRect;
    textFieldPassword.font = [UIFont systemFontOfSize:15];
    textFieldPassword.placeholder = @"Secure Name";
    textFieldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    textFieldPassword.keyboardType = UIKeyboardTypeDefault;
    textFieldPassword.returnKeyType = UIReturnKeyDone;
    textFieldPassword.secureTextEntry=YES;          // to enable dots to be displayed for password entry
    textFieldPassword.delegate=self;
    textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;  //round close button on the right corner of text field to clear all the content of the fields
    
    
    UIButton *but= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [but setFrame:CGRectMake(MarginLeft, textFieldPassword.frame.origin.y+EleSpacing, self.view.frame.size.width-(2*MarginLeft), EleWidth)];
    but.backgroundColor =[UIColor whiteColor];
    //[but setBackgroundColor:[UIColor whiteColor]];
    [but setTitle:@"Lets Play" forState:UIControlStateNormal];
    [but setExclusiveTouch:YES];
    
    UIGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]; //to detect the tap of screen to change colour dynamically
    tapper.cancelsTouchesInView = NO;
    

    [self.view addSubview:title];
    [self.view addSubview:textFieldUserName];
    [self.view addSubview:textFieldPassword];
    [self.view addSubview:but];
    [self.view addGestureRecognizer:tapper];  // adding the elements to the main View
   
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
