//
//  PortfolioCell.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "PortfolioCell.h"

@implementation PortfolioCell

- (void)awakeFromNib {
    
    self.layer.cornerRadius  = 5;
    self.layer.masksToBounds = NO;

    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = .5;
    self.layer.shadowRadius = 1.0;
    
//    [self.layer setShadowOffset:CGSizeMake(0, 2)];
//    [self.layer setShadowRadius:1.0];
//    [self.layer setShadowColor:[UIColor blackColor].CGColor] ;
//    [self.layer setShadowOpacity:0.5];
//    [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bounds] CGPath]];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;

}

@end
