//
//  UserConfig.h
//  For LoL
//
//  Created by Nax on 22.08.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfig : NSObject

- (NSInteger)getUserRegion;
- (void)setUserRegion:(NSInteger)region;

- (NSArray*)getUserFavourites;
- (void)setUserFavourites:(NSArray*)favourites;
- (void)addUserFavourite:(NSDictionary*)favourite;
- (void)removeUserFavourite:(NSString *)name fromRegion:(NSInteger)region;

- (NSArray*)getHistory;
- (void)updateHistory:(NSDictionary *)entry;

// TODO - XMPP have to be saved too - maybe encrypted or in keychain?

@end
