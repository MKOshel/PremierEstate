//
//  Residence.h
//  PremierEstate
//
//  Created by Dragos on 24/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Residence : NSObject

@property (nonatomic, strong) NSString* iD;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* purpose;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSMutableArray* features;
@property (nonatomic, strong) NSString* descr;
@property (nonatomic, strong) NSString* shortDescr;
@property (nonatomic, strong) NSString* imageURL;
@property (nonatomic, strong) UIImage* image;

@property (nonatomic, readwrite) double latitude;
@property (nonatomic, readwrite) double longitude;



@end
