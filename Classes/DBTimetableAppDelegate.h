//
//  DBTimetableAppDelegate.h
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBTimetableAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	UIImageView *splashView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

@end
