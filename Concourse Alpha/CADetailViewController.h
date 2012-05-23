//
//  CADetailViewController.h
//  Concourse Alpha
//
//  Created by Devon Tivona on 5/15/12.
//  Copyright (c) 2012 University of Colorado, Boulder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CADetailViewController : UIViewController <UISplitViewControllerDelegate>

- (void)configureView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSDictionary *properties;

@end
