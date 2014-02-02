//
//  EHTSettingsViewController.m
//  The Wife
//
//  Created by Morgan Cabral on 2/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "EHTSettingsViewController.h"

@implementation EHTSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions/Outlets
- (IBAction)didRequestFacebookAuth:(id)sender {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Authenticate with Facebook"
                                                   message:@"Facebook integration hasn't been built yet, but if it was we would ask you for your credentials here." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
}



@end
