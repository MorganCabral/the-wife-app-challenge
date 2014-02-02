//
//  EHTAppDelegate.h
//  The Wife
//
//  Created by Morgan Cabral on 1/30/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHTTaskCollection.h"

@interface EHTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*! A collection of tasks. */
@property (strong, nonatomic) EHTTaskCollection *taskCollection;

@end
