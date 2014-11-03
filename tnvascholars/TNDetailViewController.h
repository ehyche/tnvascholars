//
//  TNDetailViewController.h
//  tnvascholars
//
//  Created by Eric Hyche on 6/16/14.
//  Copyright (c) 2014 Sullivan Countty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TNDetailViewController;

@protocol TNDetailViewControllerDelegate <NSObject>

- (void)userTappedCancel:(TNDetailViewController *)detail;
- (void)userTappedDone:(TNDetailViewController *)detail;

@end

@interface TNDetailViewController : UIViewController

@property (weak, nonatomic) id<TNDetailViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *hoursTextField;

@end
