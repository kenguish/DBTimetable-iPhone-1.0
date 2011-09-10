//
//  DBTimetableAppDelegate.m
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009. All rights reserved.
//

#import "DBTimetableAppDelegate.h"


@implementation DBTimetableAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	
	
	// Splash screen stuff
	// http://michael.burford.net/2008/11/fading-defaultpng-when-iphone-app.html
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	splashView.image = [UIImage imageNamed:@"Default.png"];
	[window addSubview:splashView];
	[window bringSubviewToFront:splashView];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: 0.7];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
	[UIView setAnimationDelegate:self]; 
	[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
	splashView.alpha = 0.0;
	splashView.frame = CGRectMake(-60, -60, 440, 600);
	
	[UIView commitAnimations];		
	
	// [[UIApplication sharedApplication] setStatusBarHidden: NO withAnimation: NO];
	
}


- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	[splashView removeFromSuperview];
	[splashView release];
}

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

