//
//  AppDelegate.m
//  For LoL
//
//  Created by Nax on 27.07.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "AppDelegate.h"
#import "UIConstants.h"
#import "PKRevealController.h"
#import "FriendsTableViewController.h"

@interface AppDelegate()<PKRevealing> {
    bool menuOpen;
    bool friendsOpen;
}

#pragma mark - Properties

@property (nonatomic, strong) UIStoryboard *storyboard;

@property (nonatomic, strong, readwrite) PKRevealController *revealController;
@property (nonatomic, strong, readwrite) UINavigationController *leftViewController;
@property (nonatomic, strong, readwrite) UINavigationController *rightViewController;
@property (nonatomic, strong) FriendsTableViewController *friendsTableViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // UserConfig
    self.config = [[UserConfig alloc] init];
    
    // Riot
    self.riot = [[RiotAPI alloc] init];
    [self updateUserRegion];

    // View
    self.storyboard = [UIStoryboard storyboardWithName:iPhoneStoryboard
                                                         bundle: nil];
    
    UINavigationController *newsViewController = [self.storyboard instantiateViewControllerWithIdentifier:NewsView];
    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:MenuView];
    self.rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:FriendsView];
    self.friendsTableViewController = [self.rightViewController.viewControllers objectAtIndex:0];
    [self.friendsTableViewController registerObserver];
    
    self.revealController = [PKRevealController revealControllerWithFrontViewController:newsViewController
                                                                     leftViewController:self.leftViewController
                                                                    rightViewController:self.rightViewController];
    
    self.revealController.delegate = self;
    self.revealController.animationDuration = 0.25;
    
    menuOpen = false;
    friendsOpen = false;
    
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - PKRevealing

- (void)revealController:(PKRevealController *)revealController didChangeToState:(PKRevealControllerState)state
{
//    NSLog(@"%@ (%d)", NSStringFromSelector(_cmd), (int)state);
}

- (void)revealController:(PKRevealController *)revealController willChangeToState:(PKRevealControllerState)next
{
//    PKRevealControllerState current = revealController.state;
//    NSLog(@"%@ (%d -> %d)", NSStringFromSelector(_cmd), (int)current, (int)next);
}

#pragma mark - Views
- (void)showFronView {
    [self.revealController showViewController:self.revealController.frontViewController];
}

- (void)showMenu {
    if (menuOpen) {
        [self.revealController showViewController:self.revealController.frontViewController];
    } else {
        [self.revealController showViewController:self.revealController.leftViewController];
    }
    
    menuOpen |= menuOpen;
}

- (void)showFriends {
    if (friendsOpen) {
        [self.revealController showViewController:self.revealController.frontViewController];
    } else {
        [self.revealController showViewController:self.revealController.rightViewController];
    }
    
    friendsOpen |= friendsOpen;
}

- (void)showSettingsView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:SettingsView]];
    [self showFronView];
}

- (void)showSummonersView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:SummonerView]];
    [self showFronView];
}

- (void)showNewsView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:NewsView]];
    [self showFronView];
}

- (void)showChampionsView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:ChampionsView]];
    [self showFronView];
}

- (void)showItemsView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:ItemsView]];
    [self showFronView];
}

- (void)showVideosView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:VideosView]];
    [self showFronView];
}

- (void)showSongsView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:SongsView]];
    [self showFronView];
}

- (void)showArtsView {
    [self.revealController setFrontViewController:[self.storyboard instantiateViewControllerWithIdentifier:ArtsView]];
    [self showFronView];
}

- (void)updateUserRegion {
    [self.riot setCurrentRegion:[self.config getUserRegion]];
}

- (void)connectToChat {
    NSDictionary *userChatAccount = [self.config getUserChatAccount];
    kRegions region = [self.config getUserRegion];
    LoLServerRegion serverRegion = LoLServerRegionBrazil;
    
    if (userChatAccount != nil
        && (userChatAccount[@"username"] != nil && [userChatAccount[@"username"] length] > 0)
        && (userChatAccount[@"password"] != nil && [userChatAccount[@"username"] length] > 0)) {
        switch (region) {
            case BR:
                serverRegion = LoLServerRegionBrazil;
                break;
            case EUNE:
                serverRegion = LoLServerRegionNordicEast;
                break;
            case EUW:
                serverRegion = LoLServerRegionEuropeWest;
                break;
            case KR:
                serverRegion = LoLServerRegionKorean;
                break;
            case LAN:
                serverRegion = LoLServerRegionLatinNorth;
                break;
            case LAS:
                serverRegion = LoLServerRegionLatinSouth;
                break;
            case NA:
                serverRegion = LoLServerRegionNordicEast;
                break;
            case OCE:
                serverRegion = LoLServerRegionOceanic;
                break;
            case RU:
                serverRegion = LoLServerRegionRussia;
                break;
            case TR:
                serverRegion = LoLServerRegionTurkey;
                break;
            default:
                break;
        }
        self.folklore = [[Folklore alloc] initWithServerRegion:serverRegion withConsoleDebugOutput:NO];
        [self.folklore setDelegate:self];
        [self.folklore connectWithUsername:userChatAccount[@"username"]
                              password:userChatAccount[@"password"]];
    }
}

- (void)disconnectFromChat {
    [self.folklore disconnect];
}


#pragma mark - FolkloreDelegate Protocol

- (void)folkloreDidConnect:(Folklore *)folklore {
    NSLog(@"Connection successful");
}

- (void)folkloreConnection:(Folklore *)folklore didFailedWithError:(NSError *)error {
    NSLog(@"Connection failed with error: %@", error);
}

- (void)folklore:(Folklore *)folklore didUpdatedBuddyList:(NSArray *)buddies {
    for (FolkloreBuddy *buddy in buddies) {
        NSLog(@"%@ is %@", buddy.name, (buddy.isOnline ? @"online" : @"offline"));
    }
}

- (void)folklore:(Folklore *)folklore didReceivedMessage:(NSString *)message fromBuddy:(FolkloreBuddy *)buddy {
    NSLog(@"[%@] %@", buddy.name, message);
}

- (void)folklore:(Folklore *)folklore didPopulateBuddyList:(NSArray *)buddyList {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:buddyList forKey:@"friends"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"populateFriends" object:nil userInfo:userInfo];
}

#pragma mark - APP Delegate

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"WRA");
    [self disconnectFromChat];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"DBA");
    [self connectToChat];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
