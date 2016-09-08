//
//  ListingsVC.m
//  PremierEstate
//
//  Created by Dragos on 23/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "ListingsVC.h"
#import "ListingCell.h"
#import "RequestManager.h"
#import "Listing.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "ListingDetailVC.h"
#import "AppDelegate.h"

@interface ListingsVC ()

@end


@implementation ListingsVC



-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _listingsRadius = [NSMutableArray new];
        [_listingsRadius removeAllObjects];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
    
    _listings = [NSMutableArray new];
    
    if (_isMapSearch == NO && _isEstateListing == NO && _isPropertySearch == NO) {
        [self refreshData];
    }
    if (_isEstateListing == YES) {
        [self getListingsBasedOnEstateID];
    }
    if (_isMapSearch == YES) {
        [self getListingsBasedOnLocation];
    }
    if (_isPropertySearch == YES) {
        [self getListingsWithQuery];
    }
    

    // Do any additional setup after loading the view from its nib.
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)customizeView
{
    [_collectionV setHidden:NO];
    [_collectionV registerNib:[UINib nibWithNibName:@"ListingCell" bundle:nil] forCellWithReuseIdentifier:@"listingCell"];
}



-(void)refreshData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RequestManager sharedManager] getListings:^(id result, NSError *error) {
        _listings = (NSMutableArray*)result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_collectionV setHidden:NO];
            [_collectionV reloadData];
            if (error!= nil) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                [_collectionV setHidden:YES];
            }
        });
    }];
}


-(void)getListingsBasedOnEstateID
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RequestManager sharedManager] getListingsForEstateID:_residence.iD result:^(id result, NSError *error)
    {
        _listings = (NSMutableArray*)result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_collectionV setHidden:NO];
            [_collectionV reloadData];
            if (error!= nil) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                [_collectionV setHidden:YES];
            }
        });
    }];
}


-(void)getListingsBasedOnLocation
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RequestManager sharedManager] getListingsForLat:_latitude lng:_longitude andRadius:_radius result:^(id result, NSError *error) {
        _listings = (NSMutableArray*)result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_collectionV setHidden:NO];
            [_collectionV reloadData];
            if (error!= nil) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                [_collectionV setHidden:YES];
            }
            
        });
    }];
}


-(void)getListingsWithQuery
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RequestManager sharedManager] getListingsWithQueryURL:_queryURL result:^(id result, NSError *error) {
        _listings = (NSMutableArray*)result;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [_collectionV setHidden:NO];
            [_collectionV reloadData];
            if (error!= nil) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
                [_collectionV setHidden:YES];
            }
        });
    }];
}




#pragma mark CollectionView data & delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _listings.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListingCell* cell = (ListingCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"listingCell" forIndexPath:indexPath];
    Listing* l = _listings[indexPath.row];
        
    cell.labelTitle.text = l.title;
    cell.labelRoomsNumber.text = l.roomsNo;
    cell.labelArea.text = l.area;
    cell.labelPortfolio.text = l.portfolio;
    cell.labelPrice.text = [NSString stringWithFormat:@"€ %@",l.price];

    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[mainURL stringByAppendingString:l.imageURL]]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [cell.imgView setImageWithURLRequest:imageRequest
                       placeholderImage:nil
                                success:nil
                                failure:nil];
    
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Listing* l = _listings[indexPath.row];
    
    ListingDetailVC* detailVC = [[ListingDetailVC alloc]initWithNibName:@"ListingDetailVC" bundle:nil];
    [detailVC setListing:l];
    [appDelegate.navController pushViewController:detailVC animated:YES ];
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(310, 260);
}

#pragma mark ====



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
