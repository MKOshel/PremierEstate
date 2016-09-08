//
//  SideMenuVC.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "SideMenuVC.h"
#import "AboutVC.h"
#import "AppDelegate.h"
#import "MapSearchVC.h"
#import "Utils.h"
#import "PortfolioVC.h"
#import "PropertySearchVC.h"
#import "Defines.h"
#import "ListingsVC.h"



@interface SideMenuVC ()
{
    NSMutableArray* elements;
    NSMutableArray* elementsDesign;
    

}
@end

@implementation SideMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
 
    [self prepareDataSource];
    
}


-(void)customizeView
{
    [_tblView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)prepareDataSource
{
    elements = [[NSMutableArray alloc]initWithObjects:@"Portfolio",
                @"Listings",
                @"Special Offers",
                @"Property Search",
                @"Browse by Maps",
                @"About Us", nil];
    elementsDesign = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"ic_home"],
                      [UIImage imageNamed:@"ic_list"],
                      [UIImage imageNamed:@"ic_cup"],
                      [UIImage imageNamed:@"ic_filter"],
                      [UIImage imageNamed:@"ic_nearby"],
                      [UIImage imageNamed:@"ic_info"], nil];
}


#pragma mark TableView data & delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return elements.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    NSString* text = elements[indexPath.row];
    UIImage* img = elementsDesign[indexPath.row];
    
    cell.textLabel.text = text;
    cell.imageView.image = img;
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [appDelegate.navController popToRootViewControllerAnimated:YES];
        PortfolioVC* vc = (PortfolioVC*)appDelegate.navController.viewControllers[0];
        [vc toggleMenuAction];
        [vc.contView setHidden:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:portfolioDidLoad object:nil];
        
    }
    if (indexPath.row == 1) {
        ListingsVC* listingsVC = [[ListingsVC alloc]initWithNibName:@"ListingsVC" bundle:nil];
        [listingsVC setIsMapSearch:NO];
        [Utils addToContainerViewSubview:listingsVC];
    }
    if (indexPath.row == 2) {
        ListingsVC* listingsVC = [[ListingsVC alloc]initWithNibName:@"ListingsVC" bundle:nil];
        
        [Utils addToContainerViewSubview:listingsVC];
    }
    if (indexPath.row == 3) {
        PropertySearchVC* pSearchVC = [[PropertySearchVC alloc]initWithNibName:@"PropertySearchVC" bundle:nil];
        [Utils addToContainerViewSubview:pSearchVC];
    }
    if (indexPath.row == 4) {
        MapSearchVC* searchVC = [[MapSearchVC alloc]initWithNibName:@"MapSearchVC" bundle:nil];
        
        [Utils addToContainerViewSubview:searchVC];
    
        //[appDelegate.navController pushViewController:searchVC animated:YES];
    }
    if (indexPath.row == 5) {
        AboutVC* aboutVC = [[AboutVC alloc]initWithNibName:@"AboutVC" bundle:nil];
        [Utils addToContainerViewSubview:aboutVC];

    }
}



#pragma mark ===
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
