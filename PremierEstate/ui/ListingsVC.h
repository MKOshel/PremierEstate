//
//  ListingsVC.h
//  PremierEstate
//
//  Created by Dragos on 23/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Residence.h"

@interface ListingsVC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray* listingsRadius;
@property (nonatomic, strong) NSMutableArray* listings;
//dataSources
@property (nonatomic, readwrite) BOOL isMapSearch;
@property (nonatomic, strong) NSString* radius;
@property (nonatomic, strong) NSString* latitude;
@property (nonatomic, strong) NSString* longitude;
 // needed for estates query based on location and radius

@property (nonatomic, readwrite) BOOL isEstateListing;
@property (nonatomic, strong) Residence* residence;
// needed for estates query based on id

@property (nonatomic, readwrite) BOOL isPropertySearch;
@property (nonatomic, strong) NSString* queryURL;
@end
