//
//  ListingDetailVC.m
//  PremierEstate
//
//  Created by Oshel on 9/26/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "ListingDetailVC.h"
#import "ImageURL.h"
#import "Defines.h"
#import "UIImageView+AFNetworking.h"
#import "Utils.h"
#import "MBProgressHUD.h"
#import "RequestManager.h"
#import "PictureDetailVC.h"


@interface ListingDetailVC ()
{
    NSMutableArray* images;
    UIImageView* imageView;
    
    MKPointAnnotation* annotation;
    CLLocation* location;
}
@end

@implementation ListingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    images = [[NSMutableArray alloc]init];
    [self setDetailsWithListing:_listing];

    [_viewCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self setupViews];
    [self refreshData];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)setDetailsWithListing:(Listing*)l
{
    _labelPortfolio.text = l.portfolio;
    _labelPrice.text = [NSString stringWithFormat:@"€ %@",l.price];
    _labelBuilt.text = l.year_built;
    _labelPurpose.text = @"Sale";
    _labelCity.text = l.city;
    _labelDistrict.text = l.district;
    _labelAddress.text = l.address;
    _labelUsefulArea.text = l.area;
    _labelBuiltArea.text = l.areaBuilt;
    _labelRoomsNo.text = l.roomsNo;
    _labelBathrooms.text = l.bathroomsNo;
    _labelFloors.text = l.floor;
    _labelParking.text = l.parkingsNo;
    
//    _textViewContent.text = l.content;
//    _textViewDescr.text = l.descr;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utils detachNewThreadBlock:^{
        [_viewWeb loadHTMLString:[NSString stringWithFormat:@"%@\n%@",l.descr,l.content] baseURL:nil];
    } completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];
    
    
    
    location = [[CLLocation alloc]initWithLatitude:l.latitude longitude:l.longitude];
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

-(void)refreshData
{

    [MBProgressHUD showHUDAddedTo:_viewCollection animated:YES];
        
    [[RequestManager sharedManager] getImagesURLForEstateID:_listing.iD result:^(id result, NSError *error) {
        images = (NSMutableArray*)result;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:_viewCollection animated:YES];
                [_viewCollection setHidden:NO];
                [_viewCollection reloadData];
                if (error!= nil) {
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Oops"message:@"Please connect to the internet"                                                                                                                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                    [_viewCollection setHidden:YES];
                }
            });
        }];
        
        

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupViews
{
    
    [_contentView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, _contentView.frame.size.height)];
    [(UIScrollView*)self.view addSubview:_contentView];

    [(UIScrollView*)self.view setContentSize:_contentView.frame.size];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


#pragma mark CollectionView data & delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return images.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    imageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    imageView.image = nil;

    imageView.contentMode = UIViewContentModeScaleToFill;
    [cell.contentView addSubview:imageView];
    
    ImageURL* imgUrl = images[indexPath.row];
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[mainURL stringByAppendingString:imgUrl.pathThumb]]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [imageView setImageWithURLRequest:imageRequest
                        placeholderImage:nil
                                 success:nil
                                 failure:nil];
    
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageURL* imgUrl = images[indexPath.row];
    
    PictureDetailVC* vc = [[PictureDetailVC alloc]initWithNibName:@"PictureDetailVC" bundle:nil];
    [vc setFullImageURL:[mainURL stringByAppendingString:imgUrl.pathFullImage]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 15.0;
}
//
//
//
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30.0;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}

#pragma mark ====




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
