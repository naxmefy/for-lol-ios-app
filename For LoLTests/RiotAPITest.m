//
//  RiotAPITest.m
//  For LoL
//
//  Created by Nax on 06.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RiotAPI.h"

@interface RiotAPITest : XCTestCase

@end

@implementation RiotAPITest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRiotAPI {
    RiotAPI *riot = [[RiotAPI alloc] init];
    [riot setCurrentRegion:EUW];

    NSLog(@"API: %@", riot);
    NSLog(@"CurrentRegion: %@", [RiotAPI getRegionNameForKey:[riot currentRegion]]);
    NSLog(@"%@", [riot getChampions:YES]);

}

@end
