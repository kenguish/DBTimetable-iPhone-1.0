//
//  BusesTableViewController.h
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BusesTableViewController : UITableViewController {
	NSDictionary *routesDict;
	NSArray *routes;
	
}
@property (nonatomic, retain) NSDictionary *routesDict;
@property (nonatomic, retain) NSArray *routes;

@end
