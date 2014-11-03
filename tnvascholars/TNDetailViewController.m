//
//  TNDetailViewController.m
//  tnvascholars
//
//  Created by Eric Hyche on 6/16/14.
//  Copyright (c) 2014 Sullivan Countty. All rights reserved.
//

#import "TNDetailViewController.h"

@interface TNDetailViewController ()

@end

@implementation TNDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender {
    [self.delegate userTappedCancel:self];
}

- (IBAction)doneAction:(id)sender {
    // Check to make sure user has typed *something* into each field
    if ([self.titleTextField.text length] > 0 &&
        [self.dateTextField.text length] > 0  &&
        [self.hoursTextField.text length] > 0) {
        // User has typed in something to each of the text fields
        [self.delegate userTappedDone:self];
    } else {
        // At least one of the text fields is blank
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Activity Error"
                                                            message:@"One of the fields is blank."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end
