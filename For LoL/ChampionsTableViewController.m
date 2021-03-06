//
//  ChampionsTableViewController.m
//  For LoL
//
//  Created by Nax on 23.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "ChampionsTableViewController.h"
#import "AppDelegate.h"
#import "ChampionGeneralDetailViewController.h"

@interface ChampionsTableViewController () {
    NSArray * championsList;
}

@property (nonatomic, strong) UITabBarController *championTabBarController;
@property (nonatomic, strong) ChampionGeneralDetailViewController *championGeneralDetailViewController;

- (IBAction)showMenu:(id)sender;
@end

@implementation ChampionsTableViewController

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
    NSMutableArray *unsortedChampionsList = [[NSMutableArray alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary * championsDictionary = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] riot] getChampionList];
        NSDictionary * championsData = [championsDictionary objectForKey:@"data"];
        
        if (championsData != nil) {
            for(NSString * championName in championsData) {
                [unsortedChampionsList addObject:[championsData objectForKey:championName]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
            championsList = [unsortedChampionsList sortedArrayUsingDescriptors:sortDescriptors];
            [self.tableView reloadData];
        });
    });
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [championsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...

    cell.textLabel.text = [[championsList objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [[championsList objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[[[championsList objectAtIndex:indexPath.row] objectForKey:@"image"] objectForKey:@"full"]];
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showChampion" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showChampion"]) {
        NSIndexPath *indexPath = (NSIndexPath*)sender;
        self.championTabBarController = (UITabBarController*)segue.destinationViewController;
        self.championGeneralDetailViewController = [self.championTabBarController.viewControllers objectAtIndex:0];
        self.championGeneralDetailViewController.champion = [championsList objectAtIndex:indexPath.row];
    }
}


- (IBAction)showMenu:(id)sender {
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] showMenu];
}

@end
