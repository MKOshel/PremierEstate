//
//  Listing.h
//  PremierEstate
//
//  Created by Dragos on 25/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Listing : NSObject

@property (nonatomic, strong) NSString* iD;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* portfolio;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* area;
@property (nonatomic, strong) NSString* imageURL;
@property (nonatomic, strong) NSString* roomsNo;
//new properties
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* district;
@property (nonatomic, strong) NSString* year_built;
@property (nonatomic, strong) NSString* floor;
@property (nonatomic, strong) NSString* purpose;
@property (nonatomic, strong) NSString* bathroomsNo;
@property (nonatomic, strong) NSString* areaBuilt;
@property (nonatomic, strong) NSString* parkingsNo;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* descr;
@property (nonatomic, readwrite) double latitude;
@property (nonatomic, readwrite) double longitude;
@end
