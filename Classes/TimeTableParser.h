//
//  TimeTableParser.h
//  DBTimetable
//
//  Created by Kenneth Anguish on 12/8/09.
//  Copyright 2009 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeTableParser.h"

@interface TimeTableParser : NSObject {
	TimeTableParser *timeTableParser;
}
- (NSMutableArray *) timearrayWithFormat: (NSString *)formatname withRoute:(NSString *)routename withDate: (NSDate *)the_date;
- (NSString *)getDayOfTheWeek:(NSDate *)date;
- (NSString *)dbExtensionWithDate: (NSDate *)the_date;

- (BOOL)weekdaysCheckWithDate: (NSDate *)the_date;
- (BOOL)saturdayCheckWithDate: (NSDate *)the_date;
- (BOOL)sundayCheckWithDate: (NSDate *)the_date;
- (BOOL)holidaycheckWithDate: (NSDate*)today;

@end
