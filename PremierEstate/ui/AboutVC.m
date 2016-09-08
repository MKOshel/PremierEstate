//
//  AboutVC.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "AboutVC.h"
#import "Utils.h"
#import "MBProgressHUD.h"

#define URL @"https://www.premier-estate.eu/about-us/"
@interface AboutVC ()

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewScroll setMaximumZoomScale:5.0];
    
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    NSURL *url = [NSURL URLWithString:URL];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [_webV loadRequest:requestObj];
//
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _viewIMage;
}



-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error on webView: %@",error.description);
}




-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
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
