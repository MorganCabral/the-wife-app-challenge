//
//  EHTSettingsViewController.h
//  The Wife
//
//  Created by Morgan Cabral on 2/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHTSettings.h"

@interface EHTSettingsViewController : UITableViewController

/* The backing object which contains settings data. */
@property (strong, nonatomic) EHTSettings* settingsData;

/* Outlets used to get/set cells in the view. */
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellSortingModeAlphabetical;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellSortingModeDueSoonest;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellSortingModelMostRecent;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellFacebookAuthentication;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellFacebookPublicShaming;

@end
