//
//  CAMasterViewController.h
//  Concourse Alpha
//
//  Created by Devon Tivona on 5/15/12.
//  Copyright (c) 2012 University of Colorado, Boulder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CADetailViewController;

@interface CAMasterViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) CADetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *webViews;

@end
