//
//  FriendsTableViewController.m
//  For LoL
//
//  Created by Nax on 27.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "FriendTableViewCell.h"

#import <Folklore/Folklore.h>

@interface FriendsTableViewController () {
    NSMutableArray *onlineFriends;
    NSMutableArray *offlineFriends;
    bool onlyOnline;
}

@property (nonatomic, strong) NSArray * friends;

- (void)configCell:(UITableViewCell* )cell forFriend:(FolkloreBuddy*)friend;

// Notifiers
- (void)populateFriends:(NSNotification *)notification;
@end

@implementation FriendsTableViewController

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
    onlyOnline = YES;
    [self updateFriendStates];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count = 0;
    if (onlyOnline) {
        count = 1;
    } else {
        count = 2;
    }
    NSLog(@"Section Count: %d", count);
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int count = 0;

    if (section == 0) {
        count = [onlineFriends count];
    } else {
        count = [offlineFriends count];
    }

    NSLog(@"Friends: %d", count);
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Online";
    } else {
        return @"Offline";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    FolkloreBuddy *friend;

    if (indexPath.section == 0) {
        friend = [onlineFriends objectAtIndex:indexPath.row];
    } else {
        friend = [offlineFriends objectAtIndex:indexPath.row];
    }

    
    [self configCell:cell forFriend:friend];
    return cell;
}

- (void)configCell:(UITableViewCell *)cell forFriend:(FolkloreBuddy*)friend {
    cell.textLabel.text = friend.name;
    cell.detailTextLabel.text = friend.buddyInformations.gameStatus;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - public methods
- (void)registerObserver {
    // NotificationObserver
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateFriends:) name:@"populateFriends" object:nil];
}

#pragma mark - Observer methods
- (void)populateFriends:(NSNotification *)notification {
    NSLog(@"Update Friends");
    self.friends = [[NSArray alloc] initWithArray:[[notification userInfo] objectForKey:@"friends"]];
    [self updateFriendStates];
    [self.tableView reloadData];
}

#pragma mark - private Methods
- (void)updateFriendStates {
    onlineFriends = [[NSMutableArray alloc] init];
    offlineFriends = [[NSMutableArray alloc] init];
    
    for (FolkloreBuddy *friend in self.friends) {
        NSLog(@"%@ - %@", friend.name, friend.isOnline?@"on":@"off");
        if (friend.isOnline) {
            [onlineFriends addObject:friend];
        } else {
            [offlineFriends addObject:friend];
        }
    }
}

@end
