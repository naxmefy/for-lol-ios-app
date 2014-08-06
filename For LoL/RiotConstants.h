//
//  RiotConstants.h
//  For LoL
//
//  Created by Nax on 06.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#ifndef For_LoL_RiotConstants_h
#define For_LoL_RiotConstants_h

// API KEY
#pragma mark - API KEY
#define API_KEY @"fa1b74d8-5a16-4ac1-918d-99e790eb4957"

#pragma mark - API URL Structure
#define API_URL @"https://%@?api_key=%@&%@"

// API VERSIONS
#pragma mark - API VERSIONS
#define API_CHAMPION_VERSION                @"1.2"
#define API_GAME_VERSION                    @"1.3"
#define API_LEAGUE_VERSION                  @"2.4"
#define API_LOL_STATIC_DATA_VERSION         @"1.2"
#define API_STATS_VERSION                   @"1.3"
#define API_SUMMONER_VERSION                @"1.4"
#define API_TEAM_VERSION                    @"2.3"

// REGIONS
#pragma mark - API REGIONS
typedef enum kRegions : NSUInteger {
    BR,
    EUNE,
    EUW,
    KR,
    LAN,
    LAS,
    NA,
    OCE,
    RU,
    TR
} kRegions;
#define kRegionKeys @"BR", @"EUNE", @"EUW", @"KR", @"LAN", @"LAS", @"NA", @"OCE", @"RU", @"TR", nil
#define kRegionURL @"%@.api.pvp.net"
#define kGlobalRegion @"global.api.pvp.net"

//URLS
#pragma mark - API URLS
#pragma mark Champion
#define GET_CHAMPIONS                       @"/api/lol/%@/v1.2/champion"
#define GET_CHAMPION_ID                     @"/api/lol/%@/v1.2/champion/%@"

#pragma mark Game
#define GET_GAME                            @"/api/lol/%@/v1.3/game/by-summoner/%@/recent"

#pragma mark League
#define GET_LEAGUE_BY_SUMMONER_IDS          @"/api/lol/%@/v2.4/league/by-summoner/%@"
#define GET_LEAGUE_ENTRY_BY_SUMMONER_IDS    @"/api/lol/%@/v2.4/league/by-summoner/%@/entry"
#define GET_LEAGUE_BY_TEAM_IDS              @"/api/lol/%@/v2.4/league/by-team/%@"
#define GET_LEAGUE_ENTRY_BY_TEAM_IDS        @"/api/lol/%@/v2.4/league/by-team/%@/entry"
#define GET_CHALLENGER                      @"/api/lol/%@/v2.4/league/challenger"


#pragma mark LoL Static Data
#define GET_CHAMPION_LIST                   @"/api/lol/static-data/%@/v1.2/champion"
#define GET_CHAMPION_BY_ID                  @"/api/lol/static-data/%@/v1.2/champion/%@"
#define GET_ITEM_LIST                       @"/api/lol/static-data/%@/v1.2/item"
#define GET_ITEM_BY_ID                      @"/api/lol/static-data/%@/v1.2/item/%@"
#define GET_MASTERY_LIST                    @"/api/lol/static-data/%@/v1.2/mastery"
#define GET_MASTERY_BY_ID                   @"/api/lol/static-data/%@/v1.2/mastery/%@"
#define GET_REALM_LIST                      @"/api/lol/static-data/%@/v1.2/realm"
#define GET_RUNE_LIST                       @"/api/lol/static-data/%@/v1.2/rune"
#define GET_RUNE_BY_ID                      @"/api/lol/static-data/%@/v1.2/rune/%@"
#define GET_SUMMONER_SPELL_LIST             @"/api/lol/static-data/%@/v1.2/summoner-spell"
#define GET_SUMMONER_SPELL_BY_ID            @"/api/lol/static-data/%@/v1.2/summoner-spell/%@"
#define GET_VERSION_LIST                    @"/api/lol/static-data/%@/v1.2/versions"

#pragma mark Stats
#define GET_RANKED_STATS_BY_SUMMONER_ID     @"/api/lol/%@/v1.3/stats/by-summoner/%@/ranked"
#define GET_PLAYER_STATS_BY_SUMMONER_ID     @"/api/lol/%@/v1.3/stats/by-summoner/%@/summary"

#pragma mark Summoner
#define GET_SUMMONER_IDS_BY_NAMES           @"/api/lol/%@/v1.4/summoner/by-name/%@"
#define GET_SUMMONER_OBJECT_BY_IDS          @"/api/lol/%@/v1.4/summoner/%@"
#define GET_SUMMONER_MASTERIES_BY_IDS       @"/api/lol/%@/v1.4/summoner/%@/masteries"
#define GET_SUMMONER_NAME_BY_IDS            @"/api/lol/%@/v1.4/summoner/%@/name"
#define GET_SUMMONER_RUNES_BY_IDS           @"/api/lol/%@/v1.4/summoner/%@/runes"

#pragma mark Team
#define GET_TEAMS_BY_SUMMONER_IDS           @"/api/lol/%@/v2.3/team/by-summoner/%@"
#define GET_TEAMS_BY_TEAM_IDS               @"/api/lol/%@/v2.3/team/%@"


//Result Keys
#pragma mark - API Result Keys
NSString * const kId = @"id";
NSString * const kName = @"name";
NSString * const kLevel = @"level";

#endif
