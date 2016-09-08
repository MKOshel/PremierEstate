//
//  PictureDetailVC.m
//  PremierEstate
//
//  Created by Dragos on 28/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "PictureDetailVC.h"
#import "UIImageView+AFNetworking.h"

@interface PictureDetailVC ()

@end

@implementation PictureDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewScroll setMaximumZoomScale:3.0];
   
    [self setImage];
    
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    // Do any additional setup after loading the view from its nib.
}


-(void)setImage
{
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_fullImageURL]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [_imageView setImageWithURLRequest:imageRequest
                        placeholderImage:nil
                                 success:nil
                                 failure:nil];
}


-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

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
