//
//  EHTSettings.m
//  The Wife
//
//  Created by Morgan Cabral on 2/2/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "EHTSettings.h"

@implementation EHTSettings

+ (instancetype) settings
{
    return [[[self class] alloc] init];
}

+ (instancetype) settingsWithSortingMode:(EHTTaskSortingMode)sortingMode publicShaming:(Boolean)publicShaming
{
    EHTSettings *settings = [[self class] settings];
    settings.sortingMode = sortingMode;
    settings.publicShaming = publicShaming;
    return settings;
}

- (id)init
{
    if (self = [super init])
    {
        self.sortingMode = sortModeMostRecent;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super init])
    {
        _sortingMode = [aDecoder decodeIntForKey:EHTSettingsTaskSortingModeKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_sortingMode forKey:EHTSettingsTaskSortingModeKey];
}

@end
