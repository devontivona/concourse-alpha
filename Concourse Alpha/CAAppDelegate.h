//
//  CAAppDelegate.h
//  Concourse Alpha
//
//  Created by Devon Tivona on 5/15/12.
//  Copyright (c) 2012 University of Colorado, Boulder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAAppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (UIButton *)texturedBackButtonWithTitle:(NSString*)title;
+ (UIButton *)texturedButtonWithTitle:(NSString*)title;
+ (UIButton *)texturedButtonWithImage:(UIImage*)image;
+ (UIButton *)texturedButton;

+ (UIButton *)lightTexturedBackButtonWithTitle:(NSString*)title;
+ (UIButton *)lightTexturedButtonWithTitle:(NSString*)title;
+ (UIButton *)lightTexturedButtonWithImage:(UIImage*)image;
+ (UIButton *)lightTexturedButton;

@end
