#define URLbase @"http://premier-estate.eu/mobileadmin"
//
//  PortfolioVC.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "PortfolioVC.h"
#import "PortfolioCell.h"
#import "SideMenuVC.h"
#import "Utils.h"
#import "PortfolioDetailVC.h"
#import "RequestManager.h"
#import "MBProgressHUD.h"
#import "Residence.h"
#import "UIImageView+AFNetworking.h"



#define sideMenuWidth  self.view.frame.size.width
#define sideMenuHeight self.view.frame.size.height
#define sideMenuOriginY 0


@interface PortfolioVC ()
{
    NSMutableArray* arrayEstates;
    UIView* sideMenuView;
    SideMenuVC* sideVC;
    BOOL isVisible;
}
@end

@implementation PortfolioVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
    [self createSideMenuView];
    [self registerToNotification];
    
    arrayEstates = [NSMutableArray new];
    
    [self refreshData]; // get residences
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view from its nib.
}



-(void)registerToNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:portfolioDidLoad object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    isVisible = NO;
    
}


-(void)refreshData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RequestManager sharedManager] getPortfolio:^(id result, NSError *error) {
        arrayEstates = (NSMutableArray*)result;
        
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


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self toggleMenu:YES];
}


-(void)createSideMenuView
{
    sideMenuView = [[UIView alloc]initWithFrame:CGRectMake(-sideMenuWidth, sideMenuOriginY, sideMenuWidth - 70, sideMenuHeight )];
    sideVC = [[SideMenuVC alloc]initWithNibName:@"SideMenuVC" bundle:nil];
    
    [sideVC.view setFrame:CGRectMake(0, 0, sideMenuWidth - 70, sideMenuHeight + 200)];
     
    
    [sideMenuView addSubview:sideVC.view];
    
    [self.view addSubview:sideMenuView];
}


-(void)addCustomLeftButton
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]init];
    
    UIImage *img1=[UIImage imageNamed:@"ic_navigation_drawer.png"];
    CGRect frameimg1 = CGRectMake(0, 0, img1.size.width + 10, img1.size.height);
    UIButton *signOut=[[UIButton alloc]initWithFrame:frameimg1];
    [signOut setBackgroundImage:img1 forState:UIControlStateNormal];
    [signOut addTarget:self action:@selector(toggleMenuAction)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:signOut];
    self.navigationItem.leftBarButtonItem=barButton;
}


-(void)toggleMenuAction {

    [self.view endEditing:YES];
    [self toggleMenu:isVisible];
    
    isVisible = !isVisible;
}


-(void)toggleMenu:(BOOL)visible
{
    CGRect newFrame = sideMenuView.frame;
    newFrame.origin.x = 0;
    
    if (visible == NO) {
        //[sideMenuView setHidden:NO];
        [Utils animateViewWithAnimations:^{sideMenuView.frame = newFrame;}
                                 completion:nil];
    }
    newFrame.origin.x = -sideMenuWidth;
    
    if (visible == YES) {
        
        [Utils animateViewWithAnimations:^{sideMenuView.frame = newFrame;}
                                 completion:^(BOOL finished) {
                                     //[sideMenuView setHidden:YES];
                                     
                                 }];
    }
}


-(void)customizeView
{
    [_collectionV registerNib:[UINib nibWithNibName:@"PortfolioCell" bundle:nil] forCellWithReuseIdentifier:@"portfolioCell"];
    [self addCustomLeftButton];
    
    UIImage *logo = [UIImage imageNamed:@"ic_launcher.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark CollectionView data & delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrayEstates.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PortfolioCell* cell = (PortfolioCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"portfolioCell" forIndexPath:indexPath];

    Residence* r = arrayEstates[indexPath.row];
    
    cell.labelDescription.text = r.descr;
    cell.labelTitle.text = r.name;
    cell.labelPrice.text = r.price;

    if (r.features.count != 0) {
        cell.label_ft1.text = r.features[0];
        cell.label_ft2.text = r.features[1];
        cell.label_ft3.text = r.features[2];
        cell.label_ft4.text = r.features[3];
    }

//    UIImage* __block img;
//    [Utils detachNewThreadBlock:^{
//        img = [self getImageFromURL:[mainURL stringByAppendingString:r.imageURL]];
//        
//    } completion:^{
//            cell.imageV.image = img;
//    }];
//    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[mainURL stringByAppendingString:r.imageURL]]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [cell.imageV setImageWithURLRequest:imageRequest
                       placeholderImage:nil
                              success:nil
                              failure:nil];
    

    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Residence* r = arrayEstates[indexPath.row];
    PortfolioCell* cell = (PortfolioCell*)[collectionView cellForItemAtIndexPath:indexPath];
    r.image = cell.imageV.image; // to send it to the details controller

    PortfolioDetailVC* detailVC = [[PortfolioDetailVC alloc]initWithNibName:@"PortfolioDetail" bundle:nil];
    [detailVC setResidence:r];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width - 10, 240);
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
