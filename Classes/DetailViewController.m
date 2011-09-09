//
//  DetailViewController.m
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009 All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize filename;
@synthesize tableview, departLabel, previousLabel, timeslots, positiveTimeslots;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	timeslots = [[NSMutableArray alloc] init];
	
	timeTableParser = [[TimeTableParser alloc] init];
	
	NSDate *today = [NSDate date];
	NSTimeInterval secondsPerDay = 24 * 60 * 60;
	NSDate *tomorrow = [today addTimeInterval:secondsPerDay];
	
	NSMutableArray *todayArray = 
		[timeTableParser timearrayWithFormat: @"dbnewformat" withRoute: filename withDate: today];
	NSArray *tomorrowArray = 
		(NSArray *)[timeTableParser timearrayWithFormat: @"dbnewformat" withRoute: filename withDate: tomorrow];
	
	[todayArray addObjectsFromArray: tomorrowArray];
	timeslots = todayArray;
	
	// NSLog(@"timeslots: %@", timeslots);
	positiveTimeslots = [[NSMutableArray alloc] init];
	for (NSDictionary *timeSlotDict in timeslots) {
		if ([[timeSlotDict valueForKey: @"floatInterval"] floatValue] >= 0.0 ) {
			[positiveTimeslots addObject: timeSlotDict];
		}
	}
	
	// NSLog(@"positiveTimeslots: %@", positiveTimeslots);
	
	// previousLabel.text = [[timeslots objectAtIndex: 0] valueForKey: @"timeInterval"];
	if ([positiveTimeslots count] > 0) {
		departLabel.text = [[positiveTimeslots objectAtIndex: 0] valueForKey: @"timeInterval"];
	} else {
		departLabel.text = @"another day?";
	}
	
    [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[timeslots release];
	[timeTableParser release];
	
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [timeslots count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		CGRect timeLabelRect = CGRectMake( 10, 0, 150, 44);
		
		UILabel *timeLabel = [[UILabel alloc] initWithFrame: timeLabelRect];
		timeLabel.textAlignment = UITextAlignmentLeft;
		// enNameLabel.text = [[filteredListData objectAtIndex: row] objectAtIndex: 1];;
		timeLabel.font = [UIFont boldSystemFontOfSize: 24];
		timeLabel.tag = kTimeLabelTag;
		
		[cell.contentView addSubview: timeLabel];
		[timeLabel release];
		// timeLabel.backgroundColor = [UIColor redColor];
		
		
		CGRect timeIntervalLabelRect = CGRectMake( 160, 0, 150, 44);
		
		UILabel *timeIntervalLabel = [[UILabel alloc] initWithFrame: timeIntervalLabelRect];
		timeIntervalLabel.textAlignment = UITextAlignmentLeft;
		// enNameLabel.text = [[filteredListData objectAtIndex: row] objectAtIndex: 1];;
		timeIntervalLabel.font = [UIFont boldSystemFontOfSize: 24];
		timeIntervalLabel.tag = kTimeIntervalLabelLabelTag;
		
		timeIntervalLabel.textAlignment = UITextAlignmentRight;
		[cell.contentView addSubview: timeIntervalLabel];
		// timeIntervalLabel.backgroundColor = [UIColor greenColor];
		
		[timeIntervalLabel release];
    }
    
	// Set up the cell...
	/* NSUInteger section = [indexPath section]; */

	UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag: kTimeLabelTag];
	timeLabel.text = [[timeslots objectAtIndex: row]  valueForKey: @"itemTitle"];
	
	UILabel *timeIntervalLabel = (UILabel *)[cell.contentView viewWithTag: kTimeIntervalLabelLabelTag];
	timeIntervalLabel.text = [[timeslots objectAtIndex: row]  valueForKey: @"timeInterval"];
	
	//NSLog(@"%@\t\tPositiveTime: %@", [[timeslots objectAtIndex: row]  valueForKey: @"timeInterval"], 
	//	  [[timeslots objectAtIndex: row]  valueForKey: @"positiveTime"]);
	
	if ([(NSString *)[[timeslots objectAtIndex: row]  valueForKey: @"positiveTime"] isEqualToString: @"past"]) {
		// past 
		timeIntervalLabel.textColor = [UIColor lightGrayColor];
		timeLabel.textColor = [UIColor lightGrayColor];
	} else {
		if ([[[timeslots objectAtIndex: row]  valueForKey: @"floatInterval"] floatValue] < 42.0) {
			timeIntervalLabel.textColor = [UIColor redColor];
			timeLabel.textColor = [UIColor redColor];
		} else {
			// future
			timeIntervalLabel.textColor = [UIColor blackColor];
			timeLabel.textColor = [UIColor blackColor];
		}
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// NSUInteger row = [indexPath row];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
