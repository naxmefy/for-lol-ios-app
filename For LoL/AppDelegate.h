//
//  AppDelegate.h
//  For LoL
//
//  Created by Nax on 27.07.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiotAPI.h"
#import "UserConfig.h"
#import "MBProgressHUD.h"
#import <Folklore/Folklore.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, FolkloreDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RiotAPI *riot;
@property (strong, nonatomic) UserConfig *config;
@property (strong, nonatomic) Folklore *folklore;

- (void)showFronView;
- (void)showMenu;
- (void)showFriends;
- (void)showSettingsView;
- (void)showSummonersView;
- (void)showNewsView;
- (void)showChampionsView;
- (void)showItemsView;
- (void)showVideosView;
- (void)showSongsView;
- (void)showArtsView;

- (void)updateUserRegion;

- (void)connectToChat;
- (void)disconnectFromChat;
@end
