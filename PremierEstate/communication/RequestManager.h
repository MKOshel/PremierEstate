//
//  RequestManager.h
//  PremierEstate
//
//  Created by Dragos on 24/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Defines.h"

@interface RequestManager : NSObject

+ (RequestManager*)sharedManager;

- (void)getPortfolio:(void (^)(id result, NSError *error))block;
- (void)getImagesURLForEstateID:(NSString*)iD result:(void (^)(id result, NSError *error))block;

- (void)getListings:(void (^)(id result, NSError *error))block;
- (void)getListingsForLat:(NSString*)lat lng:(NSString*)lng andRadius:(NSString*)radius result:(void (^)(id result, NSError *error))block;
- (void)getListingsForEstateID:(NSString*)estateId result:(void (^)(id result, NSError *error))block;
- (void)getListingsWithQueryURL:(NSString*)queryURL  result:(void (^)(id result, NSError *error))block;

- (void)getCities:(void (^)(id result, NSError *error))block;
- (void)getDistricts:(void (^)(id result, NSError *error))block;

@end
