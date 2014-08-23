//
//  UserConfig.m
//  For LoL
//
//  Created by Nax on 22.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "UserConfig.h"

static const int MAXHISTORY = 10;

NSString * const kRegion = @"region";

NSString * const kFavourites = @"favourites";
NSString * const kFavouriteName = @"name";
NSString * const kFavouriteRegion = @"region";

NSString * const kHistory = @"history";

@interface UserConfig()

@property (strong, nonatomic) NSUserDefaults *userDefaults;

- (void)initUserDefaults;
- (void)save;
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
}

- (void)save {
    [self.userDefaults synchronize];
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

- (void)updateHistory:(NSDictionary *)entry {
    NSMutableArray * historyEntries = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:kHistory]];
    if ([historyEntries count] >= MAXHISTORY) {
        [historyEntries removeLastObject];
    }
    [historyEntries addObject:entry];
    [self save];
}

@end
