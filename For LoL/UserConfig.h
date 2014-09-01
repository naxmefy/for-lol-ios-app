//
//  UserConfig.h
//  For LoL
//
//  Created by Nax on 22.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject

- (void)resetUserConfig;

// Locale
- (NSString*)getUserLocale;
- (void)setUserLocale:(NSString*)locale;

// User Region
- (NSInteger)getUserRegion;
- (void)setUserRegion:(NSInteger)region;

// User Chat Account
- (NSDictionary*)getUserChatAccount;
- (void)setUserChatAccount:(NSDictionary*)userChatAccount;

// Favourite Summoners
- (NSArray*)getUserFavourites;
- (void)setUserFavourites:(NSArray*)favourites;
- (void)addUserFavourite:(NSDictionary*)favourite;
- (void)removeUserFavourite:(NSString *)name fromRegion:(NSInteger)region;

// Last Views
- (NSArray*)getHistory;
- (void)updateHistory:(NSDictionary *)entry;

// TODO - XMPP have to be saved too - maybe encrypted or in keychain?

@end
