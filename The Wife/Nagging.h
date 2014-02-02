//
//  Nagging.h
//  The Wife
//  A collection of functions related to collecting pre-generated nagging strings.
//
//  Created by Steve on 2/1/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#ifndef The_Wife_Nagging_h
#define The_Wife_Nagging_h

#ifdef THE_HUSBAND
#define EHT_SOUND_FILE_PREFIX @"husband-"
#else // if THE_WIFE
#define EHT_SOUND_FILE_PREFIX @"wife-"
#endif

static inline NSArray *naggingStrings() {
    return @[
             @"Honey",
             @"Dear",
             @"Hey",
             @"Come On",
             @"Just Do This One Thing"
             ];
}

static inline NSString *randomNaggingString() {
    NSArray *strings = naggingStrings();
    return strings[arc4random() % [strings count]];
}

static inline NSString *naggSoundFile(NSString *nagg) {
    if ([naggingStrings() containsObject:nagg]) {
        return [[NSBundle mainBundle] pathForResource:[EHT_SOUND_FILE_PREFIX stringByAppendingString:nagg] ofType:@"wav"];
    } else {
        return nil;
    }
}

#endif
