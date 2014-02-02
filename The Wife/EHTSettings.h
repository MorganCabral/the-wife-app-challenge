//
//  EHTSettings.h
//  The Wife
//
//  Created by Morgan Cabral on 2/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum EHTTaskSortingMode
{
    sortModeDueSoonest,
    sortModeMostRecent,
    sortModeAlphabetical
} EHTTaskSortingMode;

@interface EHTSettings : NSObject <NSCoding>

/* The sorting mode to use for display tasks in the All Tasks View. */
@property (nonatomic) EHTTaskSortingMode sortingMode;

/* Create a new Settings instance. */
+ (instancetype) settings;

/* Convience class for creating a new settings object with a specific group settings. */
+ (instancetype) settingsWithSortingMode:(EHTTaskSortingMode *)sortingMode;

@end
