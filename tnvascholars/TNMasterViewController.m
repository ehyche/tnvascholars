//
//  TNMasterViewController.m
//  tnvascholars
//
//  Created by Eric Hyche on 6/16/14.
//  Copyright (c) 2014 Sullivan Countty. All rights reserved.
//

#import "TNMasterViewController.h"

#import "TNDetailViewController.h"
#import "TNActivity.h"

@interface TNMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation TNMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 54.0;
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    [_objects addObject:[NSDate date]];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = 0;

    if (section == 0) {
        numRows = 3;
    } else if (section == 1) {
        numRows = _objects.count;
    }

    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *returnedCell = nil;

    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailCell"];
        }


        TNActivity *activity = _objects[indexPath.row];
        cell.textLabel.text = activity.title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Date: %@\nHours: %@", activity.date, activity.hours];
        cell.detailTextLabel.numberOfLines = 2;

        returnedCell = cell;
    } else if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleCell"];
        }

        if (indexPath.row == 0) {
            float totalHours = 0.0;
            for (TNActivity *activity in _objects) {
                float hoursFloat = [activity.hours floatValue];
                totalHours = totalHours + hoursFloat;
            }
            NSString *totalHoursStr = [NSString stringWithFormat:@"Total Hours: %@", @(totalHours)];
            cell.textLabel.text = totalHoursStr;
        } else if (indexPath.row == 1) {
            float totalHours = 0.0;
            for (TNActivity *activity in _objects) {
                float hoursFloat = [activity.hours floatValue];
                totalHours = totalHours + hoursFloat;
            }
            float hoursLeft = 80.0 - totalHours;
            NSString *hoursLeftStr = [NSString stringWithFormat:@"Hours Left: %@", @(hoursLeft)];
        }
        returnedCell = cell;
    }

    return returnedCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *header = nil;

    if (section == 0) {
        header = @"Summary";
    } else if (section == 1) {
        header = @"Activity List";
    }

    return header;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // remove the TNActivity data for this row
        [_objects removeObjectAtIndex:indexPath.row];
        // remove the UITableView row
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // Section 0 row 0 has our total hours, so we need to reload section 0 row 0
        // Tell the table view to reload section 0, row 0
        NSIndexPath* sec0row0 = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView reloadRowsAtIndexPaths:@[sec0row0]
                         withRowAnimation:UITableViewRowAnimationNone];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//    }
    // We need to set the .delegate property
//    NSString *segueID = [segue identifier];
//    NSLog(@"prepareForSegue id=%@", segueID);
//    if ([segueID isEqualToString:@"addNew"]) {
//    }
    NSString* segueID = [segue identifier];
    NSLog(@"prepareForSegue id=%@", segueID);
    if ([segueID isEqualToString:@"addNew"]) {
        // We need to set the .delegate property on the detail view controller
        UINavigationController *navController = [segue destinationViewController];

        TNDetailViewController *detail = (TNDetailViewController *)[navController topViewController];
        detail.delegate = self;
    }
}

- (void)userTappedCancel:(TNDetailViewController*)detail {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)userTappedDone:(TNDetailViewController*)detail {
    // Copy the title, date, and hours out of detail view controller
    TNActivity* activity = [[TNActivity alloc] init];
    activity.title = detail.titleTextField.text;
    activity.date  = detail.dateTextField.text;
    activity.hours = detail.hoursTextField.text;

    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }

    [_objects addObject:activity];
    [self.tableView reloadData];

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
