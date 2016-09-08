//
//  PropertySearchVC.h
//  PremierEstate
//
//  Created by Dragos on 23/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertySearchVC : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, readwrite) int type;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPurpose;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCities;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDistrict;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProperty;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRooms;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPrice;

@property (weak, nonatomic) IBOutlet UIButton *btnSearch;


@property (strong, nonatomic) NSMutableArray* arrCities;
@property (strong, nonatomic) NSMutableArray* arrDistricts;


@end
