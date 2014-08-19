//
//  RiotAPI.m
//  For LoL
//
//  Created by Nax on 06.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "RiotAPI.h"
#import "NSDictionary+UrlEncoding.h"

@interface RiotAPI ()
- (NSDictionary *)loadFromAPI:(NSString *)urlPart withParams:(NSDictionary *)params;
@end

@implementation RiotAPI
#pragma mark - Syncronize
@synthesize currentRegion;

#pragma mark - Private Methods
#pragma mark Class Methods
#pragma mark Instance Methods

- (NSDictionary *)loadFromAPI:(NSString *)urlPart withParams:(NSDictionary *)params {
    // param check
    if (params == nil) {
        params = [[NSDictionary alloc] init];
    }

    // Region Selection
    NSString *urlWithRegion = [NSString stringWithFormat:@"%@%@", [RiotAPI getRegionURLForKey:currentRegion], urlPart];

    // URL
    NSString *apiurl = API_URL;
    NSString *urlString = [NSString stringWithFormat:apiurl, urlWithRegion, API_KEY, [params urlEncodedString]];
    NSLog(@"URL: %@", urlString);

    //Fetch
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:url];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
            JSONObjectWithData:jsonData
                       options:kNilOptions
                         error:&error];
    return json;
}

#pragma mark - Public Methods
#pragma mark Class Methods

+ (NSString *)getRegionNameForKey:(kRegions)key {
    NSArray *keys = [[NSArray alloc] initWithObjects:kRegionKeys];
    return [keys objectAtIndex:key];
}

+ (kRegions)getRegionKeyForName:(NSString *)name {
    NSArray *keys = [[NSArray alloc] initWithObjects:kRegionKeys];
    NSUInteger n = [keys indexOfObject:name];
    if (n < 1) n = EUW;
    return (kRegions) n;
}

+ (NSString *)getRegionURLForKey:(kRegions)key {
    NSArray *keys = [[NSArray alloc] initWithObjects:kRegionKeys];
    NSString *name = [keys objectAtIndex:key];
    return [NSString stringWithFormat:kRegionURL, [name lowercaseString]];
}

#pragma mark Instance Methods

- (NSDictionary *)getChampions:(bool)freeToPlay {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (freeToPlay) {
        [params setValue:@"true" forKey:@"freeToPlay"];
    }
    return [self loadFromAPI:[NSString stringWithFormat:GET_CHAMPIONS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:params];
}

- (NSDictionary *)getChampion:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_CHAMPION_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:nil];
}

- (NSDictionary *)getGame:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_GAME,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:nil];
}

- (NSDictionary *)getLeagueBySummonerIds:(NSString *)id, ... {
    return nil;
}

- (NSDictionary *)getLeagueEntryBySummonerIds:(NSString *)id, ... {
    return nil;
}

- (NSDictionary *)getLeagueByTeamIds:(NSString *)id, ... {
    return nil;
}

- (NSDictionary *)getLeagueEntryByTeamIds:(NSString *)id, ... {
    return nil;
}

- (NSDictionary *)getChallenger {
    return nil;
}

- (NSDictionary *)getChampionList {
    return nil;
}

- (NSDictionary *)getChampionById:(NSString *)id {
    return nil;
}

- (NSDictionary *)getItemList {
    return nil;
}

- (NSDictionary *)getItemById:(NSString *)id {
    return nil;
}

- (NSDictionary *)getMasteryList {
    return nil;
}

- (NSDictionary *)getMasteryById:(NSString *)id {
    return nil;
}

- (NSDictionary *)getRealmList {
    return nil;
}

- (NSDictionary *)getRuneList {
    return nil;
}

- (NSDictionary *)getRuneById:(NSString *)id {
    return nil;
}

- (NSDictionary *)getSummonerSpellList {
    return nil;
}

- (NSDictionary *)getSummonerSpellById:(NSString *)id {
    return nil;
}

- (NSDictionary *)getVersionList {
    return nil;
}

- (NSDictionary *)getRankedStatsBySummonerId:(NSString *)id {
    return nil;
}

- (NSDictionary *)getPlayerStatsBySummonerId:(NSString *)id {
    return nil;
}

- (NSDictionary *)getSummonerIdsBySummonerNames:(NSString *)name, ... {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, name);
    for (NSString *arg = name; arg != nil; arg = va_arg(args, NSString*)) {
        [names addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_IDS_BY_NAMES,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [names componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getSummonerObjectsBySummonerIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_OBJECT_BY_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getSummonerMasteriesBySummonerIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_MASTERIES_BY_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getSummonerNameBySummonerIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_NAME_BY_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getSummonerRunesBySummonerIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_RUNES_BY_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getTeamsBySummonerIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_TEAMS_BY_SUMMONER_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getTeamsByTeamIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_TEAMS_BY_TEAM_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

@end
