//
//  EHTTask.h
//  The Wife
//
//  Created by Steve on 2/1/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EHTTaskMessageKey       @"EHTTaskMessageKey"
#define EHTTaskCreatedKey       @"EHTTaskCreatedKey"
#define EHTTaskLastEditedKey    @"EHTTaskLastEditedKey"
#define EHTTaskNotesKey         @"EHTTaskNotesKey"
#define EHTTaskDueDateKey       @"EHTTaskDueDateKey"
#define EHTTaskNaggKey          @"EHTTaskNaggKey"
#define EHTTaskNaggIntervalKey  @"EHTTaskNaggInterval"
#define EHTTaskIdentifierKey    @"EHTTaskIdentifierKey"
#define EHTTaskIsCompletedKey   @"EHTTaskIsCompleted"
#define EHTTaskIsOverdueKey     @"EHTTaskIsOverdue"
#define EHTTaskNotificationKey  @"EHTTaskNotification"


@interface EHTTask : NSObject <NSCoding>

/*! The user-defined message for the notification. */
@property (strong, nonatomic) NSString *message;

/*! Any user-defined notes for the task. */
@property (strong, nonatomic) NSString *notes;

/*! The date when the task was initialized. */
@property (readonly) NSDate *created;

/*! The date when the task was last scheduled. */
@property (readonly) NSDate *lastEdited;

/*! The date the task's notification is scheduled to go off. */
@property (strong, nonatomic) NSDate *dueDate;

/*! A user-defined custom message to be desplayed.
 *  If nil, a random nagg and corresponding sound is used for the notification.
 *  If non-nil, the nagg is used and a random sound is picked for the notification. */
@property (strong, nonatomic) NSString *nagg;

/*! How frequent the user will be nagged about this task with a notification.
  * Possible values include NSCalendarUnitMonth, NSCalendarUnitWeek, NSCalendarUnitWeekday, NSCalendarUnitDay, NSCalendarUnitHour, NSCalendarUnitMinute, and more. */
@property (assign, nonatomic) NSCalendarUnit naggInterval;

/*! Is the task marked as completed?
 *  Default value is NO. */
@property (assign, nonatomic) BOOL isCompleted;

/*! A unique identifying number for the task. */
@property (readonly) double identifier;

/*! Is it currently passed the task's due date? */
@property (readonly) BOOL isOverdue;

/*! The notification scheduled for the task. */
@property (readonly) UILocalNotification *notification;

/*! Create a new task instance. */
+ (instancetype)task;

/*! Convenience method for creating a new task that's ready to be scheduled. */
+ (instancetype)taskWithMessage:(NSString *)message notes:(NSString *)notes dueDate:(NSDate *)date customNagg:(NSString *)nagg naggInterval:(NSCalendarUnit)interval;

/*! Create and schedule the task's notification notification. */
- (void)schedule;

/*! Cancel the previous notification, if any, and schedule a new notifcation. */
- (void)reschedule;

/*! Cancel the notification. */
- (void)cancel;

@end
