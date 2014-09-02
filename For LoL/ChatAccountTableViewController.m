//
//  ChatAccountTableViewController.m
//  For LoL
//
//  Created by Nax on 02.09.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "ChatAccountTableViewController.h"

@interface ChatAccountTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)signIn:(id)sender;
- (IBAction)clear:(id)sender;

@end

@implementation ChatAccountTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signIn:(id)sender {
    NSLog(@"Sign In");
    [self resignResponder];
}

- (IBAction)clear:(id)sender {
    NSLog(@"Clear");
    [self resignResponder];
    [self.usernameField setText:@""];
    [self.passwordField setText:@""];
}

- (void)resignResponder {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"END");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"RETURN");
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self signIn:textField];
    }
    return YES;
}

@end
