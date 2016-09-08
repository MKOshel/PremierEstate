//
//  Utils.m
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "Utils.h"
#import "PortfolioVC.h"
#import "AppDelegate.h"

@implementation Utils


#define appDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])


+(void)animateViewWithAnimations:(void(^)(void))animations completion:(void(^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animations
                     completion:completion];
    
}


+(void)addToContainerViewSubview:(UIViewController*)child
{
    PortfolioVC* vc = (PortfolioVC*)appDelegate.navController.viewControllers[0];
    [vc toggleMenuAction];
    [vc.contView setHidden:NO];
    
    
    [child removeFromParentViewController];
    [vc addChildViewController:child];
    [child didMoveToParentViewController:vc];
    
    [child.view setFrame:CGRectMake(0, 0, vc.contView.frame.size.width, vc.contView.frame.size.height)];
    [self removeSubviewsFromView:vc.contView];
    [vc.contView addSubview:child.view];
}


+(void)removeSubviewsFromView:(UIView*)view
{
    for (UIView* subview in view.subviews) {
        [subview removeFromSuperview];
    }
}


+(void)detachNewThreadBlock:(void(^)(void))block completion:(void(^)(void))completionBlock 
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock();
        });
    });
}


+(void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:message                                                                                                                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}


+(NSString*)removeString:(NSString*)strToRemove fromString:(NSString*)str
{
   return  [str stringByReplacingOccurrencesOfString:strToRemove withString:@""];
}


//+(void)excuteBlockOnMainThread:(void(^)(void))block
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        block();
//    });
//}


@end
