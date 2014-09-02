//
//  LanguagesTableViewController.m
//  For LoL
//
//  Created by Nax on 02.09.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "LanguagesTableViewController.h"
#import "AppDelegate.h"

@interface LanguagesTableViewController () {
    NSArray * languages;
    NSIndexPath * selectedLanguage;
    UserConfig *config;
}

@end

@implementation LanguagesTableViewController

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
    config = [(AppDelegate*)[[UIApplication sharedApplication] delegate] config];
    NSString * currentLangKey = [config getUserLocale];
    
    languages = [[NSArray alloc] initWithObjects:kLanguageNames];
    for (int i = 0; i < [languages count]; i++) {
        NSString * key = [RiotAPI getLanguageKeyForLanguage:[RiotAPI getLanguageForName:languages[i]]];
        NSLog(@"%@", key);
        if ([currentLangKey isEqualToString:key]) {
            selectedLanguage = [NSIndexPath indexPathForItem:i inSection:0];
        }
    }
    
    [self.tableView reloadData];
    
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
    return [languages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = languages[(NSUInteger) indexPath.row];
    if (indexPath.row == selectedLanguage.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
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
    NSLog(@"Clicked: %d", indexPath.row);
    NSLog(@"Selected: %d", selectedLanguage.row);
    if (indexPath.row != selectedLanguage.row) {
        UITableViewCell *lastCell = [tableView cellForRowAtIndexPath:selectedLanguage];
        lastCell.accessoryType = UITableViewCellAccessoryNone;
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

        selectedLanguage = indexPath;
        NSString * newKey = [RiotAPI getLanguageKeyForLanguage:indexPath.row];
        NSLog(@"NEW KEY: %@", newKey);
        [config setUserLocale:newKey];
        [[(AppDelegate*)[[UIApplication sharedApplication] delegate] riot] clearCache];
        [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
