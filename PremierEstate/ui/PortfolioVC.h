//
//  PortfolioVC.h
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Defines.h"

@interface PortfolioVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

-(void)toggleMenuAction;

@property (weak, nonatomic) IBOutlet UIView *contView;

@end
