//
//  Utils.h
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)addToContainerViewSubview:(UIViewController*)child;
+ (void)detachNewThreadBlock:(void(^)(void))block completion:(void(^)(void))completionBlock;


+ (void)animateViewWithAnimations:(void(^)(void))animations completion:(void(^)(BOOL finished))completion;
+ (void)showAlertWithTitle:(NSString*)title message:(NSString*)message;

+ (NSString*)removeString:(NSString*)strToRemove fromString:(NSString*)str;

@end

