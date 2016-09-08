//
//  PictureDetailVC.h
//  PremierEstate
//
//  Created by Dragos on 28/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureDetailVC : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSString* fullImageURL;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroll;

@end
