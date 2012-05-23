//
//  CADetailViewController.m
//  Concourse Alpha
//
//  Created by Devon Tivona on 5/15/12.
//  Copyright (c) 2012 University of Colorado, Boulder. All rights reserved.
//

#import "CADetailViewController.h"
#import "CAAppDelegate.h"

@interface CADetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation CADetailViewController

@synthesize webView = _webView;
@synthesize properties = _properties;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)configureView
{
    if (!self.properties) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CAWebViews" ofType:@"plist"];
        self.properties = [[[NSArray alloc] initWithContentsOfFile:path] objectAtIndex:0];
    }
    
    NSString *device;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        device = @"ipad";
    } else {
        device = @"iphone";
    }
    
    self.navigationItem.title = [_properties objectForKey:@"title"];
    
    NSString *baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"CABaseURL"];
    NSString *urlString = [NSString stringWithFormat:@"%@/external.php?page=%@&device=%@", baseUrl, [_properties objectForKey:@"url"], device];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:10.0];
    [self.webView loadRequest:request];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure reload button
    
    UIButton *reloadButton;
    reloadButton = [CAAppDelegate texturedButtonWithImage:[UIImage imageNamed:@"CASyncIconLight"]];
    [reloadButton addTarget:self.webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *reloadBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:reloadButton];
    self.navigationItem.rightBarButtonItem = reloadBarButtonItem;
    
    // Remove shadow from webview
    for (UIView *view in [[[self.webView subviews] objectAtIndex:0] subviews]) { 
        if ([view isKindOfClass:[UIImageView class]]) { view.hidden = YES; } 
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIButton *backButton = [CAAppDelegate texturedBackButtonWithTitle:@"Back"];
        [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backBarButtonItem;
    }
    
    [self.webView setOpaque:NO];
    self.webView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CABackground"]];
    
    [self configureView];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{

    UIButton *menuButton = [CAAppDelegate texturedButtonWithTitle:@"Concourse"];
    [menuButton addTarget:barButtonItem.target action:barButtonItem.action forControlEvents:UIControlEventTouchUpInside];
    barButtonItem.customView = menuButton;
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
