//
//  EHTTaskCollection.m
//  The Wife
//
//  Created by Steve on 2/1/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "EHTTaskCollection.h"

static NSString *tasksKey = @"tasks";

@interface EHTTaskCollection ()
@property (readonly) NSMutableOrderedSet *tasks;
@end

@implementation EHTTaskCollection

- (id)init
{
    if (self = [super init]) {
        _tasks = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _tasks = [aDecoder decodeObjectForKey:tasksKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_tasks forKey:tasksKey];
}

- (void)addTask:(EHTTask *)task
{
    [self willChangeValueForKey:@"tasks" withSetMutation:NSKeyValueUnionSetMutation usingObjects:[NSSet setWithObject:task]];
    [_tasks addObject:task];
    [self didChangeValueForKey:@"tasks" withSetMutation:NSKeyValueUnionSetMutation usingObjects:[NSSet setWithObject:task]];
}

- (void)removeTask:(EHTTask *)task
{
    [self willChangeValueForKey:@"tasks" withSetMutation:NSKeyValueMinusSetMutation usingObjects:[NSSet setWithObject:task]];
    [_tasks removeObject:task];
    [self didChangeValueForKey:@"tasks" withSetMutation:NSKeyValueMinusSetMutation usingObjects:[NSSet setWithObject:task]];
}

- (EHTTask *)taskWithIdentifier:(double)identifier
{
    NSOrderedSet *results = [_tasks filteredOrderedSetUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %f", identifier]];
    return [results firstObject];
}

- (NSArray *)filteredTasksUsingPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors
{
    NSOrderedSet *filtered = [_tasks filteredOrderedSetUsingPredicate:predicate];
    if (sortDescriptors) {
        return [filtered sortedArrayUsingDescriptors:sortDescriptors];
    }
    return [filtered array];
}

@end
