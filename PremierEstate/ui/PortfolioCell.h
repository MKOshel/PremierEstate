//
//  PortfolioCell.h
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PortfolioCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *label_ft1;
@property (weak, nonatomic) IBOutlet UILabel *label_ft2;
@property (weak, nonatomic) IBOutlet UILabel *label_ft3;
@property (weak, nonatomic) IBOutlet UILabel *label_ft4;

@end
