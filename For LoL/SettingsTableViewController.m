//
//  SettingsTableViewController.m
//  For LoL
//
//  Created by Nax on 30.07.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AppDelegate.h"

typedef enum kSection : NSUInteger {
    LOCALIZATION,
    CHAT,
    FORLOL
} kSection;

@interface SettingsTableViewController () {
    UserConfig *userConfig;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *languageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *regionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *accountCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *resetCell;
- (IBAction)showMenu:(id)sender;

@end

@implementation SettingsTableViewController

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
    userConfig = [(AppDelegate*)[[UIApplication sharedApplication] delegate] config];
    
    self.languageCell.textLabel.text = NSLocalizedString(@"language", @"Language of User");
    NSLocale *locale = [NSLocale currentLocale];

    NSString *language = [locale displayNameForKey:NSLocaleIdentifier
                                             value:[locale localeIdentifier]];
    NSLog(@"%@", language);
    self.languageCell.detailTextLabel.text = language;
    
    self.regionCell.textLabel.text = NSLocalizedString(@"region", @"Region of User");
    self.resetCell.detailTextLabel.text = [RiotAPI getRegionNameForKey:[userConfig getUserRegion]];

    
    self.accountCell.textLabel.text = NSLocalizedString(@"account", @"Account of User");
    NSDictionary *userChatAccount = [userConfig getUserChatAccount];
    self.accountCell.detailTextLabel.text = userChatAccount[@"username"];

    self.resetCell.textLabel.text = NSLocalizedString(@"reset", @"Reset the app settings");
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headerText = @"";
    
    switch (section) {
        case LOCALIZATION:
            headerText = NSLocalizedString(@"localization_section_header", @"Localization settings header");
            break;
        case CHAT:
            headerText = NSLocalizedString(@"chat_section_header", @"Chat settings header");
            break;
        case FORLOL:
            headerText = NSLocalizedString(@"forlol_section_header", @"For LoL settings header");
            break;
        default:
            break;
    }
    
    return headerText;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *footerText = @"";
    switch (section) {
        case FORLOL:
            footerText = NSLocalizedString(@"forlol_section_footer", @"For LoL settings footer");
            break;
            
        default:
            break;
    }
    
    return footerText;
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showMenu:(id)sender {
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] showMenu];
}
@end
