//
//  UserConfig.m
//  For LoL
//
//  Created by Nax on 22.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "UserConfig.h"

static const int MAXHISTORY = 10;

NSString * const kFirst = @"first_start";

NSString * const kLocale = @"locale";
NSString * const kRegion = @"region";
NSString * const kAccount = @"account";

NSString * const kFavourites = @"favourites";
NSString * const kFavouriteName = @"name";
NSString * const kFavouriteRegion = @"region";

NSString * const kHistory = @"history";

@interface UserConfig()

@property (strong, nonatomic) NSUserDefaults *userDefaults;

- (void)initUserDefaults;
- (void)save;
- (void)setHistory:(NSArray *)history;
@end



@implementation UserConfig

- (id)init {
    self = [super init];
    if (self != nil) {
        [self initUserDefaults];
    }
    return self;
}

- (void)initUserDefaults {
    self.userDefaults = [NSUserDefaults standardUserDefaults];

    bool firstStart = [self.userDefaults boolForKey:kFirst];
    if (!firstStart) {
        [self resetUserConfig];
        [self.userDefaults setBool:YES forKey:kFirst];
    }
}

- (void)resetUserConfig {
    [self setUserLocale:[NSLocale preferredLanguages][0]];
    NSMutableDictionary *userChatAccount = [[NSMutableDictionary alloc] init];
    userChatAccount[@"username"] = @"";
    userChatAccount[@"password"] = @"";
    userChatAccount[@"logged_in"] = @0;
    [self setUserChatAccount:userChatAccount];
    [self setUserRegion:2]; // EUW
    [self setUserFavourites:[[NSArray alloc] init]];
    [self setHistory:[[NSArray alloc] init]];
}

- (void)save {
    [self.userDefaults synchronize];
}

- (NSString *)getUserLocale {
    return [self.userDefaults objectForKey:kLocale];
}

- (void)setUserLocale:(NSString *)locale {
    [self.userDefaults setObject:locale forKey:kLocale];
    [self save];
}

- (NSDictionary *)getUserChatAccount {
    return [self.userDefaults objectForKey:kAccount];
}

- (void)setUserChatAccount:(NSDictionary *)userChatAccount {
    [self.userDefaults setObject:userChatAccount forKey:kAccount];
    [self save];
}


- (NSInteger)getUserRegion {
    return [[self.userDefaults objectForKey:kRegion] intValue];
}

- (void)setUserRegion:(NSInteger)region {
    [self.userDefaults setObject:[NSNumber numberWithInt:region] forKey:kRegion];
    [self save];
}

- (NSArray*)getUserFavourites {
    return [self.userDefaults objectForKey:kFavourites];
}

- (void)setUserFavourites:(NSArray*)favourites {
    [self.userDefaults setObject:favourites forKey:kFavourites];
    [self save];
}

- (void)addUserFavourite:(NSDictionary*)favourite {
    NSMutableArray * favourites = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:kFavourites]];
    bool exist = NO;
    for (NSDictionary *fav in favourites) {
        if ([[fav objectForKey:kFavouriteName] isEqualToString:[favourite objectForKey:kFavouriteName]]) {
            if ([[fav objectForKey:kFavouriteRegion] intValue] == [[favourite objectForKey:kFavouriteRegion] intValue]) {
                exist = YES;
                break;
            }
        }
    }
    
    if (!exist) {
        [favourites addObject:favourite];
        [self setUserFavourites:favourites];
    }
}

- (void)removeUserFavourite:(NSString *)name fromRegion:(NSInteger)region {
    NSMutableArray * favourites = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:kFavourites]];
    for (NSDictionary *fav in favourites) {
        if ([[fav objectForKey:kFavouriteName] isEqualToString:name]) {
            if ([[fav objectForKey:kFavouriteRegion] intValue] == region) {
                [favourites removeObject:fav];
                [self setUserFavourites:favourites];
                break;
            }
        }
    }

}

- (NSArray*)getHistory {
    return [self.userDefaults objectForKey:kHistory];
}

- (void)setHistory:(NSArray *)history {
    [self.userDefaults setObject:history forKey:kHistory];
    [self save];
}

- (void)updateHistory:(NSDictionary *)entry {
    NSMutableArray * historyEntries = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:kHistory]];
    if ([historyEntries count] >= MAXHISTORY) {
        [historyEntries removeLastObject];
    }
    [historyEntries addObject:entry];
    [self save];
}

@end
