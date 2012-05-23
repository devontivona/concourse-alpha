//
//  CAAppDelegate.m
//  Concourse Alpha
//
//  Created by Devon Tivona on 5/15/12.
//  Copyright (c) 2012 University of Colorado, Boulder. All rights reserved.
//

#import "CAAppDelegate.h"

@implementation CAAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (UIButton *)texturedBackButtonWithBackgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedImage title:(NSString *)title
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    button.contentMode = UIViewContentModeLeft;
    
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(7.0, 15.0, 8.0, 10.0);
    [button sizeToFit];
    
    UIImage *backButtonImage = [backgroundImage stretchableImageWithLeftCapWidth:13.0 topCapHeight:2.0];
    [button setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    
    UIImage *backButtonImagePressed = [highlightedImage stretchableImageWithLeftCapWidth:13.0 topCapHeight:2.0];
    [button setBackgroundImage:backButtonImagePressed forState:UIControlStateHighlighted];
    
    return button;
}

+ (UIButton *)texturedBackButtonWithTitle:(NSString*)title
{
    return [CAAppDelegate texturedBackButtonWithBackgroundImage:[UIImage imageNamed:@"navigationButtonBack.png"] highlightedBackgroundImage:[UIImage imageNamed:@"navigationButtonBackPressed.png"] title:title];
}

+ (UIButton *)texturedButtonWithTitle:(NSString*)title {
    
    UIButton* button = [CAAppDelegate texturedButton];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    button.contentMode = UIViewContentModeLeft;
    
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(7.0, 10.0, 8.0, 10.0);
    [button sizeToFit];
    
    return button;
}

+ (UIButton *)texturedButtonWithImage:(UIImage*)image {
    
    UIButton* button = [CAAppDelegate texturedButton];
    
    [button setImage:image forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeCenter;
    
    [button sizeToFit];
    return button;
}

+ (UIButton *)texturedButton {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImage;
    UIImage *buttonImagePressed;

    buttonImage = [[UIImage imageNamed:@"navigationButtonSquare.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    buttonImagePressed = [[UIImage imageNamed:@"navigationButtonSquarePressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted];
    
    return button;
}

+ (UIButton *)lightTexturedBackButtonWithTitle:(NSString*)title
{
    UIButton *backButton = [self texturedBackButtonWithBackgroundImage:[UIImage imageNamed:@"NavigationButtonLightBack.png"] highlightedBackgroundImage:[UIImage imageNamed:@"NavigationButtonLightBackPressed.png"] title:title];
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    backButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [backButton setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    backButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    
    return backButton;
}

+ (UIButton *)lightTexturedButtonWithTitle:(NSString*)title
{
    UIButton* button = [CAAppDelegate lightTexturedButton];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.contentMode = UIViewContentModeLeft;
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    
    [button setTitle:title forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(7.0, 10.0, 8.0, 10.0);
    [button sizeToFit];
    
    return button;
}

+ (UIButton *)lightTexturedButtonWithImage:(UIImage*)image
{
    UIButton* button = [CAAppDelegate lightTexturedButton];
    
    [button setImage:image forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeCenter;
    
    [button sizeToFit];
    return button;
}

+ (UIButton *)lightTexturedButton
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *buttonImage;
    UIImage *buttonImagePressed;

    buttonImage = [[UIImage imageNamed:@"NavigationButtonLight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    buttonImagePressed = [[UIImage imageNamed:@"NavigationButtonLightPressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted];
    
    return button;
}

@end
