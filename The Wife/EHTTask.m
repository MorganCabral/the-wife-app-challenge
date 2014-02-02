//
//  EHTTask.m
//  The Wife
//
//  Created by Steve on 2/1/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "EHTTask.h"
#import "Nagging.h"

@interface EHTTask ()

@property (strong, nonatomic) NSDate *lastEdited;
@property (assign, nonatomic) double identifier;
@property (strong, nonatomic) UILocalNotification *notification;

@end


@implementation EHTTask

+ (instancetype)task
{
    return [[[self class] alloc] init];
}

+ (instancetype)taskWithMessage:(NSString *)message notes:(NSString *)notes dueDate:(NSDate *)date customNagg:(NSString *)nagg naggInterval:(NSCalendarUnit)interval
{
    EHTTask *t = [[self class] task];
    t.message = message;
    t.notes = notes;
    t.dueDate = date;
    t.nagg = nagg;
    t.naggInterval = interval;
    return t;
}

- (id)init
{
    if (self = [super init]) {
        _naggInterval = NSCalendarUnitMinute;
        _isCompleted = NO;
        _identifier = [[NSDate date] timeIntervalSinceNow];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _message = [aDecoder decodeObjectForKey:EHTTaskMessageKey];
        _notes = [aDecoder decodeObjectForKey:EHTTaskNotesKey];
        _created = [aDecoder decodeObjectForKey:EHTTaskCreatedKey];
        _lastEdited = [aDecoder decodeObjectForKey:EHTTaskLastEditedKey];
        _dueDate = [aDecoder decodeObjectForKey:EHTTaskDueDateKey];
        _nagg = [aDecoder decodeObjectForKey:EHTTaskNaggKey];
        _naggInterval = [aDecoder decodeIntegerForKey:EHTTaskNaggIntervalKey];
        _identifier = [aDecoder decodeDoubleForKey:EHTTaskIdentifierKey];
        _isCompleted = [aDecoder decodeBoolForKey:EHTTaskIsCompletedKey];
        _notification = [aDecoder decodeObjectForKey:EHTTaskNotificationKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_message forKey:EHTTaskMessageKey];
    [aCoder encodeObject:_notes forKey:EHTTaskNotesKey];
    [aCoder encodeObject:_created forKey:EHTTaskCreatedKey];
    [aCoder encodeObject:_lastEdited forKey:EHTTaskLastEditedKey];
    [aCoder encodeObject:_dueDate forKey:EHTTaskDueDateKey];
    [aCoder encodeObject:_nagg forKey:EHTTaskNaggKey];
    [aCoder encodeInteger:_naggInterval forKey:EHTTaskNaggIntervalKey];
    [aCoder encodeDouble:_identifier forKey:EHTTaskIdentifierKey];
    [aCoder encodeBool:_isCompleted forKey:EHTTaskIsCompletedKey];
    [aCoder encodeObject:_notification forKey:EHTTaskNotificationKey];
}

- (BOOL)isOverdue
{
    switch ([[NSDate date] compare:self.dueDate]) {
        case NSOrderedSame:
        case NSOrderedDescending:
            return YES;
            
        case NSOrderedAscending:
            return NO;
    }
}

- (void)schedule
{
    if (self.dueDate) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = self.message;
        notification.alertAction = @"Yes Dear";
        
        NSString *nagg = self.nagg ?: randomNaggingString();
        notification.soundName = naggSoundFile(self.nagg ? randomNaggingString() : nagg);
        
        notification.fireDate = self.dueDate;
        notification.repeatInterval = self.naggInterval;
        
        
        notification.userInfo = @{
                                  EHTTaskNaggKey : nagg,
                                  EHTTaskIdentifierKey : @(self.identifier)
                                  };
        
        self.notification = notification;
        switch ([[NSDate date] compare:self.dueDate]) {
            case NSOrderedSame:
            case NSOrderedDescending:
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                break;
            
            case NSOrderedAscending:
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                break;
        }
    }
    self.lastEdited = [NSDate date];
}

- (void)reschedule
{
    [self cancel];
    [self schedule];
}

- (void)cancel
{
    if (self.notification) {
        [[UIApplication sharedApplication] cancelLocalNotification:self.notification];
        self.notification = nil;
    }
}

- (void)dealloc
{
    _notification = nil;
    _message = nil;
    _notes = nil;
    _created = nil;
    _lastEdited = nil;
    _dueDate = nil;
    _nagg = nil;
}

@end
