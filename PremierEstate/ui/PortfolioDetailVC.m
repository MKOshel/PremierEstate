//
//  PortfolioDetailVC.m
//  PremierEstate
//
//  Created by Dragos on 23/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "PortfolioDetailVC.h"
#import "ListingsVC.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import "Defines.h"



#define offset 200

@interface PortfolioDetailVC ()
{
    MKPointAnnotation* annotation;
    CLLocation* location;
}
@end

@implementation PortfolioDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
    [self setupViews];
    
 }


-(void)customizeView
{
    _viewMap.layer.cornerRadius = 5.0;
    _viewMap.layer.masksToBounds = YES;
    _btnListings.layer.cornerRadius = 5.0;
    _btnListings.layer.masksToBounds = YES;
    
    [_tableViewFeatures registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(void)setupViews
{
    [self.view addSubview:_viewDetails];
    
    [self setDetailsFromResidence:_residence];
    
    CGSize sizeThatFitsTextView = [_viewText sizeThatFits:CGSizeMake(_viewText.frame.size.width, MAXFLOAT)];
    
    if ([UIScreen mainScreen].bounds.size.height <= 568) {
         _textViewHeightConstraint.constant = sizeThatFitsTextView.height + 30 ;
    }
    else _textViewHeightConstraint.constant = sizeThatFitsTextView.height ;
    
    [_viewDetails setFrame:CGRectMake(_viewDetails.frame.origin.x, _viewDetails.frame.origin.y, [UIScreen mainScreen].bounds.size.width, _viewDetails.frame.size.height + _textViewHeightConstraint.constant - offset)];
    
    [(UIScrollView*)self.view setContentSize:_viewDetails.frame.size];

}


-(void)setDetailsFromResidence:(Residence*)r
{
    _viewText.text = r.descr;
    _labelName.text = r.name;
    _labelPrice.text = r.price;
    _imageView.image = r.image;
    
    if (!r.purpose.intValue == 0) {
        _labelPurpose.text = r.purpose;
    }

    location = [[CLLocation alloc]initWithLatitude:r.latitude longitude:r.longitude];
    annotation = [[MKPointAnnotation alloc]init];
    
    annotation.coordinate = location.coordinate;
    
    [self zoomInToLocation:location];
    [_viewMap addAnnotation:annotation];
}



-(void)zoomInToLocation:(CLLocation*)l
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(l.coordinate, 800, 800);
    [_viewMap setRegion:[_viewMap regionThatFits:region] animated:YES];
    
    [_viewMap setRegion:region animated:NO];
}



#pragma mark TableView data & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _residence.features.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSString* text = _residence.features[indexPath.row];
    
    cell.textLabel.text = text;
    cell.imageView.image = [UIImage imageNamed:@"key_check.png"];
    
    
    return cell;
}

#pragma mark ===
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onListingsPressed:(UIButton *)sender {
    
    ListingsVC* lVC = [[ListingsVC alloc]initWithNibName:@"ListingsVC" bundle:nil];
    [lVC setIsEstateListing:YES];
    [lVC setResidence:_residence];
    
    [self.navigationController pushViewController:lVC animated:YES];
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
