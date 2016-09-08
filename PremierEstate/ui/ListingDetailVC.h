//
//  ListingDetailVC.h
//  PremierEstate
//
//  Created by Oshel on 9/26/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listing.h"
#import <MapKit/MapKit.h>

@interface ListingDetailVC : UIViewController

@property (strong, nonatomic) Listing* listing;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UICollectionView *viewCollection;
@property (weak, nonatomic) IBOutlet MKMapView *viewMap;

@property (strong, nonatomic) IBOutlet UILabel *labelPortfolio;
@property (strong, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) IBOutlet UILabel *labelBuilt;
@property (strong, nonatomic) IBOutlet UILabel *labelPurpose;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;
@property (strong, nonatomic) IBOutlet UILabel *labelDistrict;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelUsefulArea;
@property (strong, nonatomic) IBOutlet UILabel *labelBuiltArea;
@property (strong, nonatomic) IBOutlet UILabel *labelRoomsNo;
@property (strong, nonatomic) IBOutlet UILabel *labelBathrooms;
@property (weak, nonatomic) IBOutlet UILabel *labelFloors;
@property (weak, nonatomic) IBOutlet UILabel *labelParking;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescr;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

@property (weak, nonatomic) IBOutlet UIWebView *viewWeb;

@end
