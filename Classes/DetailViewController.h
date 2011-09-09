//
//  DetailViewController.h
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeTableParser.h"

#define kTimeLabelTag 1
#define kTimeIntervalLabelLabelTag 2

@interface DetailViewController : UIViewController {
	NSString *filename;
	IBOutlet UITableView *tableview;
	IBOutlet UILabel *departLabel;
	IBOutlet UILabel *previousLabel;
	
	NSMutableArray *timeslots;
	NSMutableArray *positiveTimeslots;
	
	TimeTableParser *timeTableParser;
}
@property (nonatomic, retain) NSString *filename;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UILabel *departLabel;
@property (nonatomic, retain) IBOutlet UILabel *previousLabel;

@property (nonatomic, retain) NSMutableArray *timeslots;
@property (nonatomic, retain) NSMutableArray *positiveTimeslots;

@end
