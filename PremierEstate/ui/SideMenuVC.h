//
//  SideMenuVC.h
//  PremierEstate
//
//  Created by Dragos on 22/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end
