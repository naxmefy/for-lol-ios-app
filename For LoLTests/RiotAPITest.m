//
//  RiotAPITest.m
//  For LoL
//
//  Created by Nax on 06.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RiotAPI.h"

@interface RiotAPITest : XCTestCase {
    RiotAPI *riot;
}

@end

@implementation RiotAPITest

NSString * const kNAX_NAME = @"Naxmeify";
NSString * const kNAX_ID = @"29942842";

NSString * const kALI_NAME = @"Aligertor";
NSString * const kALI_ID = @"19971607";

NSString * const kTEAM_A = @"TEAM-f6f8e1a0-3bc8-11e2-96d4-782bcb497d6f";
NSString * const kTEAM_B = @"TEAM-4588a6a0-52c3-11e2-96c8-782bcb4ce61a";

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    riot = [[RiotAPI alloc] init];
    [riot setCurrentRegion:EUW];

    //NSLog(@"API: %@", riot);
    //NSLog(@"CurrentRegion: %@", [RiotAPI getRegionNameForKey:[riot currentRegion]]);
    //NSLog(@"%@", [riot getChampions:YES]);
    //NSLog(@"%@", [riot getSummonerIdsBySummonerNames:kNAX_NAME, kALI_NAME, nil]);
    //NSLog(@"%@", [riot getSummonerObjectsBySummonerIds:kNAX_ID, kALI_ID, nil]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCurrentRegion {
    XCTAssertEqual(EUW, [riot currentRegion]);
}

- (void)testFeaturedChampionList {
    NSDictionary *championList = [riot getChampions:YES];
    XCTAssertEqual([championList[@"champions"] count], 10);
}

- (void)testSummoner {
    NSDictionary *nax = [riot getSummonerObjectsBySummonerIds:kNAX_ID, nil];
    XCTAssertEqualObjects([nax[kNAX_ID][@"id"] stringValue], kNAX_ID);

    NSDictionary *naxMasteries = [riot getSummonerMasteriesBySummonerIds:kNAX_ID, nil];
    NSLog(@"%@", naxMasteries);
    NSDictionary *naxRunes = [riot getSummonerRunesBySummonerIds:kNAX_ID, nil];
    NSLog(@"%@", naxRunes);

}

- (void)testSummonerNames {
    NSDictionary *summonersByName = [riot getSummonerIdsBySummonerNames:kNAX_NAME, kALI_NAME, nil];
    XCTAssertNotNil(summonersByName[[kNAX_NAME lowercaseString]]);
    XCTAssertNotNil(summonersByName[[kALI_NAME lowercaseString]]);
    NSDictionary *summonerNamesByIds = [riot getSummonerNameBySummonerIds:kNAX_ID, kALI_ID, nil];
    XCTAssertEqualObjects(summonerNamesByIds[kNAX_ID], kNAX_NAME);
    XCTAssertEqualObjects(summonerNamesByIds[kALI_ID], kALI_NAME);
}

- (void)testTeamsWithSummoners {
    NSDictionary *teams = [riot getTeamsBySummonerIds:kNAX_ID, kALI_ID, nil];
    XCTAssertEqual([teams count], 1);
    XCTAssertEqual([teams[kNAX_ID] count], 2);
}

- (void)testTeamsWithTeams {
    NSDictionary *teams = [riot getTeamsByTeamIds:kTEAM_A, kTEAM_B, nil];
    XCTAssertEqual([teams count], 2);
}

@end
