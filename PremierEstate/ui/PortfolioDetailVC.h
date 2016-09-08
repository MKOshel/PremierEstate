//
//  PortfolioDetailVC.h
//  PremierEstate
//
//  Created by Dragos on 23/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Residence.h"

@interface PortfolioDetailVC : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) Residence* residence;

@property (strong, nonatomic) IBOutlet UIView *viewDetails;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *viewText;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelPurpose;
@property (weak, nonatomic) IBOutlet UITableView *tableViewFeatures;
@property (weak, nonatomic) IBOutlet MKMapView *viewMap;
@property (weak, nonatomic) IBOutlet UIButton *btnListings;

@end
