//
//  MapSearchVC.h
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapSearchVC : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet MKMapView *viewMap;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRadius;

@property (strong, nonatomic) CLLocationManager* locationManager;
@end
