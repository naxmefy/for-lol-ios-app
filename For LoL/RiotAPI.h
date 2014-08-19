//
//  RiotAPI.h
//  For LoL
//
//  Created by Nax on 06.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RiotConstants.h"

@interface RiotAPI : NSObject {
    kRegions currentRegion;
}

@property kRegions currentRegion;

// Regions
+ (NSString *)getRegionNameForKey:(kRegions)key;

+ (kRegions)getRegionKeyForName:(NSString *)name;

+ (NSString *)getRegionURLForKey:(kRegions)key;

// Champions
- (NSDictionary *)getChampions:(bool)freeToPlay;

- (NSDictionary *)getChampion:(NSString *)id;

// Game
- (NSDictionary *)getGame:(NSString *)id;

// League
- (NSDictionary *)getLeagueBySummonerIds:(NSString *)id, ...;

- (NSDictionary *)getLeagueEntryBySummonerIds:(NSString *)id, ...;

- (NSDictionary *)getLeagueByTeamIds:(NSString *)id, ...;

- (NSDictionary *)getLeagueEntryByTeamIds:(NSString *)id, ...;

- (NSDictionary *)getChallenger;

// LoL Static Data
- (NSDictionary *)getChampionList;

- (NSDictionary *)getChampionById:(NSString *)id;

- (NSDictionary *)getItemList;

- (NSDictionary *)getItemById:(NSString *)id;

- (NSDictionary *)getMasteryList;

- (NSDictionary *)getMasteryById:(NSString *)id;

- (NSDictionary *)getRealmList;

- (NSDictionary *)getRuneList;

- (NSDictionary *)getRuneById:(NSString *)id;

- (NSDictionary *)getSummonerSpellList;

- (NSDictionary *)getSummonerSpellById:(NSString *)id;

- (NSDictionary *)getVersionList;

// Stats
- (NSDictionary *)getRankedStatsBySummonerId:(NSString *)id;

- (NSDictionary *)getPlayerStatsBySummonerId:(NSString *)id;

// Summoner
- (NSDictionary *)getSummonerIdsBySummonerNames:(NSString *)name, ...;

- (NSDictionary *)getSummonerObjectsBySummonerIds:(NSString *)id, ...;

- (NSDictionary *)getSummonerMasteriesBySummonerIds:(NSString *)id, ...;

- (NSDictionary *)getSummonerNameBySummonerIds:(NSString *)id, ...;

- (NSDictionary *)getSummonerRunesBySummonerIds:(NSString *)id, ...;

// Team
- (NSDictionary *)getTeamsBySummonerIds:(NSString *)id, ...;

- (NSDictionary *)getTeamsByTeamIds:(NSString *)id, ...;

@end
