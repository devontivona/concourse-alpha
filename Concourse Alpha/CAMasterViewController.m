//
//  CAMasterViewController.m
//  Concourse Alpha
//
//  Created by Devon Tivona on 5/15/12.
//  Copyright (c) 2012 University of Colorado, Boulder. All rights reserved.
//

#import "CAMasterViewController.h"
#import "CADetailViewController.h"
#import "CAAppDelegate.h"

@implementation CAMasterViewController
@synthesize detailViewController = _detailViewController;
@synthesize webViews = _webViews;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Concourse";

    self.detailViewController = (CADetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CAWebViews" ofType:@"plist"];
    _webViews = [[NSArray alloc] initWithContentsOfFile:path];
    
    UIButton *settingsButton;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        settingsButton = [CAAppDelegate texturedButtonWithImage:[UIImage imageNamed:@"CASettingsIconLight"]];

        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"CANavbar"] forBarMetrics:UIBarMetricsDefault];   

    } else {
        
        settingsButton = [CAAppDelegate lightTexturedButtonWithImage:[UIImage imageNamed:@"CASettingsIcon"]];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"CANavbarLight"] forBarMetrics:UIBarMetricsDefault];
        
        UIColor *textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        UIColor *shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        NSValue *textOffset = [NSValue valueWithCGSize:CGSizeMake(0.0, 1.0)];
        NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:textColor, UITextAttributeTextColor, shadowColor, UITextAttributeTextShadowColor, textOffset, UITextAttributeTextShadowOffset, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
        
        [self.detailViewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"CANavbarLarge"] forBarMetrics:UIBarMetricsDefault];
        
        textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        textOffset = [NSValue valueWithCGSize:CGSizeMake(0.0, -1.0)];
        titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:textColor, UITextAttributeTextColor, shadowColor, UITextAttributeTextShadowColor, textOffset, UITextAttributeTextShadowOffset, nil];
        [self.detailViewController.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
    
    [settingsButton addTarget:self action:@selector(showSettingsDialog) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settingsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    self.navigationItem.rightBarButtonItem = settingsBarButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad  &&
        UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) &&
        [self.tableView indexPathForSelectedRow] == nil) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];   
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _webViews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSDictionary *webView = [_webViews objectAtIndex:indexPath.row];
    cell.textLabel.text = [webView objectForKey:@"title"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *webView = [_webViews objectAtIndex:indexPath.row];    
        self.detailViewController.properties = webView;
        [self.detailViewController configureView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *webView = [_webViews objectAtIndex:indexPath.row];
        
        CADetailViewController *destinationViewController = (CADetailViewController *)segue.destinationViewController;
        destinationViewController.properties = webView;
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)showSettingsDialog
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Set Base URL" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0]; 
    textField.placeholder = @"http://everlater.local";
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"CABaseURL"];
        
    // Show alert on screen.
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        return; 
    }
    
    UITextField *field = [alertView textFieldAtIndex:0];    
    [[NSUserDefaults standardUserDefaults] setObject:field.text forKey:@"CABaseURL"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
