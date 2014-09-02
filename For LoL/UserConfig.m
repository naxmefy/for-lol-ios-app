//
//  UserConfig.m
//  For LoL
//
//  Created by Nax on 22.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "UserConfig.h"
#import "RiotAPI.h"

static const int MAXHISTORY = 10;

NSString * const kFirst = @"first_start";
NSString * const kAppleLanguages = @"AppleLanguages";

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
- (NSString *)findPreferredLanguage;
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
    [self setUserLocale:[self findPreferredLanguage]];
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

- (NSString *)findPreferredLanguage {
    NSString *foundLang = nil;
    NSArray *languages = [[NSArray alloc] initWithObjects:kLanguageKeys];
    NSString *preferredLang = [[[NSLocale preferredLanguages] objectAtIndex:0] substringToIndex:2];
    for (NSString *lang in languages) {
        if ([lang rangeOfString:preferredLang].location != NSNotFound ) {
            foundLang = lang;
            break;
        }
    }

    if (foundLang == nil) {
        foundLang = [RiotAPI getLanguageKeyForLanguage:EN_US];
    }

    return foundLang;
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
        if ([fav[kFavouriteName] isEqualToString:favourite[kFavouriteName]]) {
            if ([fav[kFavouriteRegion] intValue] == [favourite[kFavouriteRegion] intValue]) {
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
        if ([fav[kFavouriteName] isEqualToString:name]) {
            if ([fav[kFavouriteRegion] intValue] == region) {
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
