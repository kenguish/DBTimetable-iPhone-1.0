//
//  TimeTableParser.m
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009 All rights reserved.
//

#import "TimeTableParser.h"


@implementation TimeTableParser



- (NSMutableArray *) timearrayWithFormat: (NSString *)formatname withRoute:(NSString *)routename withDate: (NSDate *)the_date {
	
	NSString *route_path = [NSString stringWithFormat: @"%@%@", routename, [self dbExtensionWithDate: the_date ]];

	NSString *fullPath = [[NSBundle mainBundle] pathForResource: route_path ofType:@"txt" inDirectory:@"dbnewformat"];
	
	NSMutableArray *timearray = [[NSMutableArray alloc] init];
	NSError *error;
	
	NSString *stringFromFileAtPath = [[NSString alloc]
                                      initWithContentsOfFile: fullPath
                                      encoding:NSUTF8StringEncoding
                                      error:&error];
	
	NSArray *rawtimearray = [stringFromFileAtPath componentsSeparatedByString:@"\n"];
	
	// NSDate *current_time = the_date;
	
	// NSLog(@"Current time is: %@", current_time);
	// NSLog(@"Day of week is %@", [self getDayOfTheWeek: current_time ]);
	
	NSEnumerator *keyEnumerator = [rawtimearray objectEnumerator];
	NSString *aKey;
	
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	
	NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
	[dayFormatter setDateFormat:@"yyyy-MM-dd"];
	
	while (aKey = [keyEnumerator nextObject])
	{
		NSDate *today_formatter_date = [inputFormatter dateFromString: [NSString stringWithFormat: @"%@ %@", [dayFormatter stringFromDate: the_date], aKey]];
		//NSString *date_and_time = [NSString stringWithFormat: @"%@  ", aKey];
		
		/*
		 if (([today_formatter_date timeIntervalSinceNow] / 60.0) < 130) {
			if (([today_formatter_date timeIntervalSinceNow] / 60.0) == 1) {
				date_and_time = [NSString stringWithFormat: @"%@         %.0f min", aKey, ([today_formatter_date timeIntervalSinceNow] / 60.0)];
				
			} else {
				date_and_time = [NSString stringWithFormat: @"%@         %.0f mins", aKey, ([today_formatter_date timeIntervalSinceNow] / 60.0)];
			}
		} else {
			date_and_time = [NSString stringWithFormat: @"%@  ", aKey];
		}
		*/
		// NSDictionary *aDict = [NSDictionary dictionaryWithObject: date_and_time forKey: @"itemTitle"];
		
		NSString *positiveTime;
		if (([today_formatter_date timeIntervalSinceNow] / 60.0) >= 0.0) {
			positiveTime = @"future";
		} else {
			positiveTime = @"past";
		}
		
		NSDictionary *aDict = [NSDictionary dictionaryWithObjectsAndKeys:
							   aKey, 
							   @"itemTitle", 
							   [NSString stringWithFormat: @"%.0f mins", ([today_formatter_date timeIntervalSinceNow] / 60.0)],
							   @"timeInterval",
							   [NSNumber numberWithFloat: ([today_formatter_date timeIntervalSinceNow] / 60.0)],
							   @"floatInterval",
							   positiveTime,
							   @"positiveTime",
							   nil];
		
		// NSLog(@"DEBUG> today_formatter_date: %@, current_time: %@, diff: %.0f", today_formatter_date, current_time, [today_formatter_date timeIntervalSinceNow] );
		
	//	NSLog(@"Time --> %@", aKey);
		
		if (aKey == nil || [aKey isEqualToString: @""]) {
			// NSLog(@"---> Skip printing it out!");
		} else {
			if (([today_formatter_date timeIntervalSinceNow] / 60.0) > -21) {
				[timearray addObject: aDict ];
			}
		}
	}
	[inputFormatter release];
	[dayFormatter release];
	
	/*
	 for (id timeslot in timearray)
	 
	 {
	 NSLog(@"key: %@", timeslot);
	 }
	 */
	
	// NSLog dictionaries
	// NSDictionary *dictionary = [NSDictionary dictionaryWithObject: @"5:00pm" forKey: @"itemTitle"];
	
	return timearray;
}


- (NSString *)getDayOfTheWeek:(NSDate *)date {
	/*
	 [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	 [dateFormatter setDateFormat:@"w"];
	 
	 NSString *formattedDateString = [dateFormatter stringFromDate:date];
	 return formattedDateString;
	
	NSLocale *us_locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
	NSString *weekdayString = [date descriptionWithCalendarFormat:@"%A" timeZone:nil
															locale: us_locale];
	 [us_locale release];

	return weekdayString;
	 */
	
	NSLog(@"getDayOfTheWeek> %@", date);
	
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *weekdayComponents =
	[gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate: date];
	NSInteger weekday = [weekdayComponents weekday];
	
	[gregorian release];
	NSLog(@"weekdayComponents> %d", weekday);
	
	if (weekday == 1) {
		return @"Sunday";
	} else if (weekday == 2) {
		return @"Monday";
	} else if (weekday == 3) {
		return @"Tuesday";
	} else if (weekday == 4) {
		return @"Wednesday";
	} else if (weekday == 5) {
		return @"Thursday";
	} else if (weekday == 6) {
		return @"Friday";
	} else if (weekday == 7) {
		return @"Saturday";
	} else {
		return @"unknown";
	}
	
}

- (NSString *)dbExtensionWithDate: (NSDate *)the_date {
	
	/*
	 if ([self holidaycheckWithDate: the_date]) {
		 NSLog(@"DEBUG> Today is a holiday");
	 } else {
		 NSLog(@"DEBUG> Today is NOT a holiday");
	 }
	 
	 if ([self weekdaysCheckWithDate: the_date]) {
		 NSLog(@"DEBUG> Today is a weekday");
	 } else {
		 NSLog(@"DEBUG> Today is NOT a weekday");	
	 }
	 
	 if ([self saturdayCheckWithDate: the_date]) {
		 NSLog(@"DEBUG> Today is a Saturday");
	 } else {
		 NSLog(@"DEBUG> Today is NOT a Saturday");	
	 }
	 
	 if ([self sundayCheckWithDate: the_date]) {
		 NSLog(@"DEBUG> Today is a Sunday");
	 } else {
		 NSLog(@"DEBUG> Today is NOT a Sunday");	
	 }*/
	
	if (([self weekdaysCheckWithDate: the_date]) && (![self holidaycheckWithDate: the_date])) {
		//NSLog(@"return _Weekdays");
		return @"_Weekdays";
	} else if (([self sundayCheckWithDate: the_date]) || ([self holidaycheckWithDate: the_date])) {
		//NSLog(@"return _Sunday_and_Public_Holiday");
		return @"_Sunday_and_Public_Holiday";
	} else if ([self saturdayCheckWithDate: the_date])  {
		//NSLog(@"return _Saturday");
		return @"_Saturday";
	}
	
	return @" ";
}

- (BOOL)weekdaysCheckWithDate: (NSDate *)the_date {
	NSString *todays_weekday = [self getDayOfTheWeek: the_date];
	
	if ( [todays_weekday isEqualToString:@"Monday"] || 
		[todays_weekday isEqualToString:@"Tuesday"] ||
		[todays_weekday isEqualToString:@"Wednesday"] ||
		[todays_weekday isEqualToString:@"Thursday"] ||
		[todays_weekday isEqualToString:@"Friday"] ) {
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)saturdayCheckWithDate: (NSDate *)the_date {
	NSString *todays_weekday = [self getDayOfTheWeek:the_date];
	
	if ( [todays_weekday isEqualToString:@"Saturday"] ) {
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)sundayCheckWithDate: (NSDate *)the_date {
	NSString *todays_weekday = [self getDayOfTheWeek: the_date];
	if ( [todays_weekday isEqualToString:@"Sunday"] ) {
		return YES;
	} else {
		return NO;
	}
}



- (BOOL)holidaycheckWithDate: (NSDate*)today {
	NSError *error;
	NSString *holidayFullPath = [[NSBundle mainBundle] pathForResource: @"hk_public_holidays" ofType:@"txt" inDirectory:@""];
	NSString *holidayFromFileAtPath = [[NSString alloc]
									   initWithContentsOfFile: holidayFullPath
									   encoding:NSUTF8StringEncoding
									   error:&error];
	// NSLog(@"DEBUG> holidayFromFileAtPath: %@", holidayFromFileAtPath );
	NSArray *holidaysarray = [holidayFromFileAtPath componentsSeparatedByString:@"\n"];
	NSEnumerator *holidayKeyEnumerator = [holidaysarray objectEnumerator];
	NSString *holidayKey;
	
	NSMutableArray *holidays_list_array = [[NSMutableArray alloc] init];
	
	while (holidayKey = [holidayKeyEnumerator nextObject])
	{
		// NSLog( @"-->dateWithNaturalLanguageString holidayKey: %@, %@", holidayKey, [NSDate dateWithNaturalLanguageString: holidayKey  ] );
		// [holidays_list_array addObject: [NSDate dateWithNaturalLanguageString: holidayKey]  ];
	
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
		NSDate *dateFromString = [[NSDate alloc] init];
		dateFromString = [dateFormatter dateFromString: holidayKey];
		// NSLog(@"dateFromString>>: %@", dateFromString);
		
		if (dateFromString != nil) {
			[holidays_list_array addObject: dateFromString ];
			[dateFromString release];
		}
		// NSLog(@"--------------------------");
	}
	
	NSLog(@"Holidays list: %@", holidays_list_array);
	
	/* Today's date*/
	// NSLog( @"DEBUG> Time now is %@", today );
	
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *today_formatter_date = [inputFormatter dateFromString: [NSString stringWithFormat: @"%@", [NSDate date]]];
	
	return [holidays_list_array containsObject: today_formatter_date];
}

@end
