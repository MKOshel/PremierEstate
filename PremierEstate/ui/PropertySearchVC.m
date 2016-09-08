//
//  PropertySearchVC.m
//  PremierEstate
//
//  Created by Dragos on 23/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "PropertySearchVC.h"
#import "ListingsVC.h"
#import "AppDelegate.h"
#import "Defines.h"
#import "Utils.h"
#import "RequestManager.h"
#import "MBProgressHUD.h"

#import "City.h"
#import "District.h"

@interface PropertySearchVC ()
{
    NSMutableArray* pickerData;
    NSMutableDictionary* queryParams;
    NSString* queryURL;
    UIPickerView* pickerView;
    
    NSString* strPurpose;
    NSString* strCities;
    NSString* strDistrict;
    NSString* strProperty;
    NSString* strRooms;
    NSString* strPrice;
}
@end

@implementation PropertySearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
    [self customizeView];
    
    [self initPickerView];
    
    queryParams = [NSMutableDictionary new];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)setFirstTextOnFields
{
    _textFieldCities.text = @"Bucuresti";
    _textFieldPurpose.text = @"Sale";
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


-(void)customizeView
{
    _btnSearch.layer.cornerRadius = 5.0;
    _btnSearch.layer.masksToBounds = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];

}


- (void)animateView:(UIView*)view up:(BOOL)up
{
    const int movementDistance = 80;
    const float movementDuration = 0.3;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView animateWithDuration:movementDuration animations:^{
        view.frame = CGRectOffset(view.frame, 0, movement);
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)endEditing:(UITapGestureRecognizer*)sender
{

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TextField delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if ([textField isEqual:_textFieldRooms] || [textField isEqual:_textFieldPrice]) {
        [self animateView:self.view up:NO];
    }

    
    
    if ([textField isEqual:_textFieldPurpose]) {
        if ([textField.text isEqualToString:@"Sale"]) {
            strPurpose = @"0";
        }
        else if ([textField.text isEqualToString:@"Rent"]) {
            strPurpose = @"1";
        }
        else [queryParams setValue:@"" forKey:@""];

        [queryParams setValue:strPurpose forKey:@"&purpose="];
    }
    if ([textField isEqual:_textFieldCities]) {
        strCities = [self getIDbyName:textField.text];
        
        if ([strCities isEqual :@"" ]) {
            [queryParams setValue:@"" forKey:@""];

        }
        else [queryParams setValue:strCities forKey:@"&county="];
    }
    if ([textField isEqual:_textFieldDistrict]) {
        strDistrict = [self getIDbyName:textField.text];
        if ([strDistrict isEqual :@"" ]) {
            [queryParams setValue:@"" forKey:@""];
         }
         else [queryParams setValue:strDistrict forKey:@"&cities="];
    }
    if ([textField isEqual:_textFieldProperty] ) {
        strProperty = textField.text;
        if ([strProperty isEqual :@"" ]) {
            [queryParams setValue:@"" forKey:@""];

        }
        else [queryParams setValue:strProperty forKey:@"&property_type="];
    }
    if ([textField isEqual:_textFieldRooms]) {
        strRooms = textField.text;
        if ([strRooms isEqual :@"" ]) {
            [queryParams setValue:@"" forKey:@""];

        }
        else [queryParams setValue:strRooms forKey:@"&rooms="];
    }
    if ([textField isEqual:_textFieldPrice]) {
        strPrice = textField.text;
        if ([strPrice isEqual :@"" ]) {
            [queryParams setValue:@"" forKey:@""];
        }
        else [queryParams setValue:strPrice forKey:@"&max_price="];
    }
    
    queryURL = [self getURLStringBasedOnData:queryParams];
    NSLog(@"QUERY_URL :%@",queryURL);

    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    if ([textField isEqual:_textFieldPurpose]) {
        _type = TYPE_PURPOSE;
        [self changedDataForTextField:textField];
    }
    if ([textField isEqual:_textFieldCities]) {
        _type = TYPE_CITY;
        [self changedDataForTextField:textField];
    }
    if ([textField isEqual:_textFieldDistrict]) {
        _type = TYPE_DISTRICT;
        [self changedDataForTextField:textField];
    }
    
    if ([textField isEqual:_textFieldRooms] || [textField isEqual:_textFieldPrice]) {
        [self animateView:self.view up:YES];
    }
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark PickerView
-(void)initPickerView
{
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    //pickerData = (NSMutableArray*)@[@"Sale",@"Rent"];
    
    _textFieldPurpose.inputView = pickerView;
    _textFieldCities.inputView = pickerView;
    _textFieldDistrict.inputView = pickerView;
    
}


-(void)changedDataForTextField:(UITextField*)textField
{
    if ([textField isEqual:_textFieldPurpose]) {
        pickerData = (NSMutableArray*)@[@"Sale",@"Rent"];

    }
    else if ([textField isEqual:_textFieldCities])
    {
        pickerData = _arrCities;
    }
    else {
        pickerData = _arrDistricts;
    }
    
    
    [pickerView reloadAllComponents];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (_type == TYPE_CITY) {
        return [(City*)pickerData[row] name];
    }
    if (_type == TYPE_DISTRICT) {
        return [(District*)pickerData[row] name];

    }
    
    return pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    NSString* str = pickerData[row];
    
    if (_type == TYPE_PURPOSE) {
        NSString* str = pickerData[row];
        _textFieldPurpose.text = str;

    }
    if (_type == TYPE_CITY) {
        NSString* str = [(City*)pickerData[row] name];
        _textFieldCities.text = str;
    }
    if (_type == TYPE_DISTRICT) {
        NSString* str = [(District*)pickerData[row] name];
        _textFieldDistrict.text = str;
    }
    
}


-(NSString*)getURLStringBasedOnData:(NSDictionary*)dict
{
    NSString* baseURL = URLproperty;
    
    
    if ([dict allKeys].count > 0) {
        for (NSString* key in dict) {
            NSString* paramAndValue = [NSString stringWithFormat:@"%@%@",key,[dict valueForKey:key]];
            NSString* url = [NSString stringWithFormat:@"%@%@",baseURL,paramAndValue];
            baseURL = url;
        }
    }
    
    
    return baseURL;
}


-(NSString*)getIDbyName:(NSString*)name
{
    for (id object in pickerData) {
        if ([[object name] isEqualToString:name]) {
            return [object ID];
        }
    }
    
    return @"";
}



- (IBAction)onPropertySearch:(UIButton *)sender {
    
    ListingsVC* lVC = [[ListingsVC alloc]initWithNibName:@"ListingsVC" bundle:nil];
    
    [lVC setIsPropertySearch:YES];
    [lVC setQueryURL:queryURL];
    
    [appDelegate.navController pushViewController:lVC animated:YES];
}


-(void)getData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RequestManager sharedManager] getCities:^(id result, NSError *error) {
        _arrCities = result;
    }];
    
    [[RequestManager sharedManager] getDistricts:^(id result, NSError *error) {
        _arrDistricts = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            if (error!= nil) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                
            }
        });
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
