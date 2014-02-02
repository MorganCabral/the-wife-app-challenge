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
    
    _settingsData = [EHTSettings settingsWithSortingMode:sortModeAlphabetical publicShaming:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Load in settings.
    [self configureView];
}

- (void)configureView
{
    if( self.settingsData )
    {
        // Set up the Task Sorting Mode list.
        switch ( _settingsData.sortingMode ) {
            case sortModeAlphabetical:
                _tableCellSortingModeAlphabetical.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
                
            case sortModeDueSoonest:
                _tableCellSortingModeDueSoonest.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
                
            case sortModeMostRecent:
                _tableCellSortingModelMostRecent.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
                
            default:
                break;
        }
        
        // Set up the Facebook Shaming cell.
        _tableCellFacebookPublicShaming.accessoryType = _settingsData.publicShaming ?
                                                        UITableViewCellAccessoryCheckmark :
                                                        UITableViewCellAccessoryNone;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)didRequestFacebookAuth:(id)sender {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Authenticate with Facebook"
                                            message:@"Facebook integration hasn't been built yet, but if it was we would ask you for your credentials here." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
}

#pragma mark - Table Magic.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Bit of ugly code but it works.
    if( _tableCellSortingModeAlphabetical.selected )
    {
        // Set the sorting mode.
        _settingsData.sortingMode = sortModeAlphabetical;
        
        // Unmark the other cells.
        [self clearTaskSortCellAccessories];
        
        // Mark this cell as the selected on.
        _tableCellSortingModeAlphabetical.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else if( _tableCellSortingModeDueSoonest.selected )
    {
        // Set the sorting mode.
        _settingsData.sortingMode = sortModeDueSoonest;
        
        // Unmark the other cells.
        [self clearTaskSortCellAccessories];
        
        // Mark this cell as the selected on.
        _tableCellSortingModeDueSoonest.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if( _tableCellSortingModelMostRecent.selected )
    {
        // Set the sorting mode.
        _settingsData.sortingMode = sortModeMostRecent;
        
        // Unmark the other cells.
        [self clearTaskSortCellAccessories];
        
        // Mark this cell as the selected on.
        _tableCellSortingModelMostRecent.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    if( _tableCellFacebookPublicShaming.selected )
    {
        // Toggle Shaming.
        Boolean shaming = self.settingsData.publicShaming;
        _settingsData.publicShaming = !shaming;
        
        // Make it so that the checkmark shows if shaming is enabled.
        _tableCellFacebookPublicShaming.accessoryType = shaming ?
                                            UITableViewCellAccessoryCheckmark :
                                            UITableViewCellAccessoryNone;
        
        // Unselect the cell so it can be toggled again if needed.
        _tableCellFacebookPublicShaming.selected = false;
    }
}

- (void)toggleTableCellCheckmark:(UITableViewCell *) cell
{
    Boolean isCheckmark = cell.accessoryType == UITableViewCellAccessoryCheckmark;
    cell.accessoryType = isCheckmark ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
}

- (void)clearTaskSortCellAccessories
{
    self.tableCellSortingModeAlphabetical.accessoryType = UITableViewCellAccessoryNone;
    self.tableCellSortingModeDueSoonest.accessoryType = UITableViewCellAccessoryNone;
    self.tableCellSortingModelMostRecent.accessoryType = UITableViewCellAccessoryNone;
}

@end
