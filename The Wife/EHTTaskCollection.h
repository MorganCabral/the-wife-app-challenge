//
//  EHTTaskCollection.h
//  The Wife
//
//  Created by Steve on 2/1/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHTTask.h"

@interface EHTTaskCollection : NSObject <NSCoding>

/*! Add a task to the collection. */
- (void)addTask:(EHTTask *)task;

/*! Remove a task from the collection */
- (void)removeTask:(EHTTask *)task;

/*! Get an array of tasks filtered by the given predicate and optionally sorted using the given sort descriptos. 
 *  If nil is supplied to the sort descriptors, the filtered array is returned unsorted. */
- (NSArray *)filteredTasksUsingPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

/*! Get the task with the given identifier, if it exists. */
- (EHTTask *)taskWithIdentifier:(double)identifier;

@end
