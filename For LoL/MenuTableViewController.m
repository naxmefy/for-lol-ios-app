//
//  MenuTableViewController.m
//  For LoL
//
//  Created by Nax on 30.07.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "MenuTableViewController.h"
#import "AppDelegate.h"

@interface MenuTableViewController ()
- (IBAction)showSettings:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *summonerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *newsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *championsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *itemsCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *videosCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *songsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *artsCell;
@end

@implementation MenuTableViewController

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
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == self.summonerCell) {
        [appDelegate showSummonersView];
    }
    
    else if (cell == self.newsCell) {
        [appDelegate showNewsView];
    }
    
    else if (cell == self.championsCell) {
        [appDelegate showChampionsView];
    }
    
    else if (cell == self.itemsCell) {
        [appDelegate showItemsView];
    }
    
    else if (cell == self.videosCell) {
        [appDelegate showVideosView];
    }
    
    else if (cell == self.songsCell) {
        [appDelegate showSongsView];
    }
    
    else if (cell == self.artsCell) {
        [appDelegate showArtsView];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showSettings:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showSettingsView];
}
@end
