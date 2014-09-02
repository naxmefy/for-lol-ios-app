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
#define API_KEY @"fa1b74d8-5a16-4ac1-918d-99e790eb4957" // this is only a development key - dont use this in production version....please dont use my app :P

#pragma mark - API URL Structure
#define API_URL @"https://%@?api_key=%@&%@"

// API VERSIONS
#pragma mark - API VERSIONS
#define API_CHAMPION_VERSION                @"1.2"
#define API_GAME_VERSION                    @"1.3"
#define API_LEAGUE_VERSION                  @"2.4"
#define API_LOL_STATIC_DATA_VERSION         @"1.2"
#define API_MATCH_VERSION                   @"2.2"
#define API_MATCHHISTORY_VERSION            @"2.2"
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
    TR,
    GLOBAL
} kRegions;
#define kRegionKeys @"BR", @"EUNE", @"EUW", @"KR", @"LAN", @"LAS", @"NA", @"OCE", @"RU", @"TR", nil
#define kRegionURL @"%@.api.pvp.net"
#define kGlobalRegion @"global.api.pvp.net"

// LANGUAGES
#pragma mark - API REGIONS
typedef enum kLanguage : NSUInteger {
    EN_US,
    DE_DE,
    ES_ES,
    FR_FR,
    IT_IT,
    PL_PL,
    EL_GR,
    RO_RO,
    PT_BR,
    TR_TR,
    TH_TH,
    VN_VN,
    ID_ID,
    RU_RU,
    KO_KR,
    ZH_CN,
    ZH_TW
} kLanguage;
#define kLanguageKeys @"en_US", @"de_DE", @"es_ES", @"fr_FR", @"it_IT", @"pl_PL", @"el_GR", @"ro_RO", @"pt_BR", @"tr_TR", @"th_TH", @"vn_VN", @"id_ID", @"ru_RU", @"ko_KR", @"zh_CN", @"zh_TW", nil
#define kLanguageNames @"English", @"German", @"Spanish", @"French", @"Italian", @"Polish", @"Greek", @"Romanian", @"Portuguese", @"Turkish", @"Thai", @"Vietnamese", @"Indonesian", @"Russian", @"Korean", @"Chinese (China)", @"Chinese (Taiwan)", nil


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

#pragma mark Match
#define GET_MATCH                           @"/api/lol/%@/v2.2/match/%@"

#pragma mark Matchhistory
#define GET_MATCHHISTORY                    @"/api/lol/%@/v2.2/matchhistory/%@"

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


#pragma mark - Game Constants
#pragma mark Maps
#define kMapIds @1, @2, @3, @4, @8, @10, @12, nil
#define kMapNames @"Summoner's Rift", @"Summoner's Rift", @"The Proving Grounds", @"Twisted Treeline", @"The Crystal Scar", @"Twisted Treeline", @"Howling Abyss", nil
#define kMapNotes @"Summer Variant", @"Autumn Variant", @"Tutorial Map", @"Original Version", @"Dominion Map", @"Current Version", @"ARAM Map", nil

#pragma mark Game Modes
#define kGameModes @"CLASSIC", @"ODIN", @"ARAM", @"TUTORIAL", @"ONEFORALL", @"FIRSTBLOOD", nil
#define kGameModesDescription @"Classic Summoner's Rift and Twisted Treeline games", @"Dominion/Crystal Scar games", @"ARAM games". @"Tutorial games", @"One for All games", @"Snowdown Showdown games" nil

#pragma mark Game Types
typedef enum kGameType : NSUInteger {
    GT_CUSTOM_GAME,
    GT_TUTORIAL_GAME,
    GT_MATCHED_GAME
}kGameType;

#pragma mark Game Sub Types
typedef enum kGameSubType : NSUInteger {
    GST_NONE,
    GST_NORMAL,
    GST_NORMAL_3x3,
    GST_ODIN_UNRANKED,
    GST_ARAM_UNRANKED_5x5,
    GST_BOT,
    GST_BOT_3x3,
    GST_RANKED_SOLO_5x5,
    GST_RANKED_TEAM_3x3,
    GST_RANKED_TEAM_5x5,
    GST_ONEFORALL_5x5,
    GST_FIRSTBLOOD_1x1,
    GST_FIRSTBLOOD_2x2,
    GST_SR_6x6,
    GST_CAP_5x5,
    GST_URF,
    GST_URF_BOT,
    GST_NIGHTMARE_BOT
}kGameSubType;

typedef enum kPlayerStatSummaryType: NSUInteger {
    PSST_Unranked,
    PSST_Unranked3x3,
    PSST_OdinUnranked,
    PSST_AramUnranked5x5,
    PSST_CoopVsAI,
    PSST_CoopVsAI3x3,
    PSST_RankedSolo5x5,
    PSST_RankedTeam3x3,
    PSST_RankedTeam5x5,
    PSST_OneForAll5x5,
    PSST_FirstBlood1x1,
    PSST_FirstBlood2x2,
    PSST_SummonersRift6x6,
    PSST_CAP5x5,
    PSST_URF,
    PSST_URFBots
}kPlayerStatSummaryType;

#pragma mark Rune Slots
// 01 - 09 = RED
// 10 - 18 = YELLOW
// 19 - 27 = BLUE
// 28 - 30 = ESSENCE

#pragma mark - API Result Keys

#endif
