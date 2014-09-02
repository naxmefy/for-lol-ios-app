//
//  RiotAPI.m
//  For LoL
//
//  Created by Nax on 06.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "RiotAPI.h"
#import "NSDictionary+UrlEncoding.h"
#import "AppDelegate.h"

NSString *const kCache = @"cache";
NSString *const kCacheContent = @"content";
NSString *const kCacheTime = @"time";

@interface RiotAPI () {
    UserConfig *config;
}

@property(strong, nonatomic) NSUserDefaults *cache;

- (NSDictionary *)loadFromAPI:(NSString *)urlPart withParams:(NSDictionary *)params;

- (NSDictionary *)loadFromAPI:(NSString *)urlPart withParams:(NSDictionary *)params withCache:(bool)withCache asGlobal:(bool)asGlobal;

- (NSDictionary *)getLocale:(NSDictionary *)existingParams;

- (NSDictionary *)staticDataParams:(NSString *)fetchKey;

- (NSDictionary *)getCache;

- (NSDictionary *)getFromCache:(NSString *)key;

- (void)putContent:(NSDictionary *)content intoCache:(NSString *)key;

- (void)setCacheEntry:(NSDictionary *)cacheEntry forKey:key;
@end

@implementation RiotAPI

#pragma mark - Syncronize
@synthesize currentRegion;

#pragma mark - Private Methods
#pragma mark Class Methods
#pragma mark Instance Methods

- (NSDictionary *)loadFromAPI:(NSString *)urlPart withParams:(NSDictionary *)params {
    return [self loadFromAPI:urlPart withParams:params withCache:YES asGlobal:NO];
}

- (NSDictionary *)loadFromAPI:(NSString *)urlPart withParams:(NSDictionary *)params withCache:(bool)withCache asGlobal:(bool)asGlobal {
    // param check
    if (params == nil) {
        params = [[NSDictionary alloc] init];
    }

    // Update currentRegion
    if (config == nil) {
        config = [(AppDelegate *) [[UIApplication sharedApplication] delegate] config];
    }
    currentRegion = (kRegions) [config getUserRegion];

    // Region Selection
    NSString *urlWithRegion = [NSString stringWithFormat:@"%@%@", [RiotAPI getRegionURLForKey:currentRegion], urlPart];
    if (asGlobal) {
        urlWithRegion = [NSString stringWithFormat:@"%@%@", kGlobalRegion, urlPart];
    }

    // URL
    NSString *apiurl = API_URL;
    NSString *urlString = [NSString stringWithFormat:apiurl, urlWithRegion, API_KEY, [params urlEncodedString]];
    NSLog(@"URL: %@", urlString);

    // Check cache
    NSDictionary *cacheEntry = [self getFromCache:urlString];
    if (cacheEntry != nil) {
        return [cacheEntry objectForKey:kCacheContent];
    }

    //Fetch
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSData *jsonData = [[NSData alloc] initWithContentsOfURL:url];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
            JSONObjectWithData:jsonData
                       options:kNilOptions
                         error:&error];

    [self putContent:json intoCache:urlString];

    return json;
}

- (NSDictionary *)getLocale:(NSDictionary *)existingParams {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (existingParams != nil) {
        [params addEntriesFromDictionary:existingParams];
    }
    if (config == nil) {
        config = [(AppDelegate *) [[UIApplication sharedApplication] delegate] config];
    }
    NSLog(@"localeIdentifier: %@", [config getUserLocale]);
    [params setObject:[config getUserLocale] forKey:@"locale"];

    return params;
}

- (NSDictionary *)staticDataParams:(NSString *)fetchKey {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"all" forKey:fetchKey];
    return [self getLocale:params];
}

- (NSDictionary *)getCache {
    return [self.cache objectForKey:kCache];
}

- (NSDictionary *)getFromCache:(NSString *)key {
    NSDictionary *cacheEntry = [[self getCache] objectForKey:key];
    NSDate *now = [[NSDate alloc] init];
    NSDate *cacheTime = [cacheEntry objectForKey:kCacheTime];
    if (fabs([now timeIntervalSinceDate:cacheTime]) < 3600) {
        return cacheEntry;
    }
    return nil;
}

- (void)putContent:(NSDictionary *)content intoCache:(NSString *)key {
    if ([self getFromCache:key] == nil) {
        NSMutableDictionary *cacheEntry = [[NSMutableDictionary alloc] init];
        [cacheEntry setObject:content forKey:kCacheContent];
        [cacheEntry setObject:[[NSDate alloc] init] forKey:kCacheTime];

        [self setCacheEntry:cacheEntry forKey:key];
    }
}

- (void)setCacheEntry:(NSDictionary *)cacheEntry forKey:key {
    NSMutableDictionary *cacheEntries = [[NSMutableDictionary alloc] initWithDictionary:[self getCache]];
    [cacheEntries setObject:cacheEntry forKey:key];

    [self.cache setObject:cacheEntries forKey:kCache];
    [self.cache synchronize];
}

#pragma mark - Public Methods
#pragma mark Class Methods

+ (NSString *)getChatHost {
    // GET currentRegion
    NSInteger region = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] config] getUserRegion];
    NSString *host = nil;
    switch (region) {
        case BR:
            host = CHAT_BR;
            break;
        case EUNE:
            host = CHAT_EUNE;
            break;
        case EUW:
            host = CHAT_EUW;
            break;
        case KR:
            host = CHAT_KR;
            break;
        case LAN:
            host = CHAT_LAN;
            break;
        case LAS:
            host = CHAT_LAS;
            break;
        case NA:
            host = CHAT_NA;
            break;
        case OCE:
            host = CHAT_OCE;
            break;
        case RU:
            host = CHAT_RU;
            break;
        case TR:
            host = CHAT_TR;
            break;

    }

    return host;
}

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
    NSString *name = keys[key];
    return [NSString stringWithFormat:kRegionURL, [name lowercaseString]];
}

+ (NSString *)getLanguageNameForLanguage:(kLanguage)lang {
    NSArray *names = [[NSArray alloc] initWithObjects:kLanguageNames];
    return [names objectAtIndex:lang];
}

+ (kLanguage)getLanguageForName:(NSString *)name {
    NSArray *names = [[NSArray alloc] initWithObjects:kLanguageNames];
    NSUInteger n = [names indexOfObject:name];
    if (n < 1) n = EN_US;
    return (kLanguage) n;
}

+ (NSString *)getLanguageKeyForLanguage:(kLanguage)lang {
    NSArray *keys = [[NSArray alloc] initWithObjects:kLanguageKeys];
    return keys[lang];
}

+ (kLanguage)getLanguageForKey:(NSString *)key {
    NSArray *keys = [[NSArray alloc] initWithObjects:kLanguageKeys];
    NSUInteger n = [keys indexOfObject:key];
    if (n < 1) n = EN_US;
    return (kLanguage) n;
}

+ (NSString *)getMapNameForId:(NSInteger)id {
    NSArray *mapIds = [[NSArray alloc] initWithObjects:kMapIds];
    NSInteger index = [mapIds indexOfObject:@(id)];
    NSArray *mapNames = [[NSArray alloc] initWithObjects:kMapNames];
    return mapNames[(NSUInteger) index];
}

+ (NSString *)getMapNoteForId:(NSInteger)id {
    NSArray *mapIds = [[NSArray alloc] initWithObjects:kMapIds];
    NSInteger index = [mapIds indexOfObject:@(id)];
    NSArray *mapNotes = [[NSArray alloc] initWithObjects:kMapNotes];
    return mapNotes[(NSUInteger) index];
}

#pragma mark Instance Methods

- (id)init {
    self = [super init];
    if (self != nil) {
        self.cache = [NSUserDefaults standardUserDefaults];
    }

    return self;
}

- (void)clearCache {
    [self.cache setObject:nil forKey:kCache];
}

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
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_LEAGUE_BY_SUMMONER_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getLeagueEntryBySummonerIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_LEAGUE_ENTRY_BY_SUMMONER_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getLeagueByTeamIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_LEAGUE_BY_TEAM_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getLeagueEntryByTeamIds:(NSString *)id, ... {
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, id);
    for (NSString *arg = id; arg != nil; arg = va_arg(args, NSString*)) {
        [ids addObject:arg];
    }
    va_end(args);

    return [self loadFromAPI:[NSString stringWithFormat:GET_LEAGUE_ENTRY_BY_TEAM_IDS,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        [ids componentsJoinedByString:@","]]
                  withParams:nil];
}

- (NSDictionary *)getChallenger {
    return [self loadFromAPI:[NSString stringWithFormat:GET_CHALLENGER,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:nil];
}

- (NSDictionary *)getChampionList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_CHAMPION_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:[self staticDataParams:@"champData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getChampionById:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_CHAMPION_BY_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:[self staticDataParams:@"champData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getItemList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_ITEM_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:[self staticDataParams:@"itemListData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getItemById:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_ITEM_BY_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:[self staticDataParams:@"itemData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getMasteryList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_MASTERY_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:[self staticDataParams:@"masteryListData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getMasteryById:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_MASTERY_BY_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:[self staticDataParams:@"masteryData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getRealmList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_REALM_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:nil withCache:YES asGlobal:YES];
}

- (NSDictionary *)getRuneList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_RUNE_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:[self staticDataParams:@"runeListData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getRuneById:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_RUNE_BY_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:[self staticDataParams:@"runeData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getSummonerSpellList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_SPELL_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:[self staticDataParams:@"spellData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getSummonerSpellById:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_SUMMONER_SPELL_BY_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:[self staticDataParams:@"spellData"] withCache:YES asGlobal:YES];
}

- (NSDictionary *)getVersionList {
    return [self loadFromAPI:[NSString stringWithFormat:GET_VERSION_LIST,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString]]
                  withParams:nil withCache:YES asGlobal:YES];
}

- (NSDictionary *)getMatch:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_MATCH,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:nil];
}

- (NSDictionary *)getMatchHistory:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_MATCHHISTORY,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:nil];
}

- (NSDictionary *)getRankedStatsBySummonerId:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_RANKED_STATS_BY_SUMMONER_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:nil];
}

- (NSDictionary *)getPlayerStatsBySummonerId:(NSString *)id {
    return [self loadFromAPI:[NSString stringWithFormat:GET_PLAYER_STATS_BY_SUMMONER_ID,
                                                        [[RiotAPI getRegionNameForKey:currentRegion] lowercaseString],
                                                        id]
                  withParams:nil];
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
