//
//  EHTMessageKetchupViewController.m
//  The Wife
//
//  Created by Morgan Cabral on 2/1/14.
//  Copyright (c) 2014 RIT. All rights reserved.
//

#import "EHTMessageKetchupViewController.h"

@interface EHTMessageKetchupViewController ()

@end

@implementation EHTMessageKetchupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create messages.
    [self didCreateMessages];
}

- (void)didCreateMessages
{
    // Create a bunch of things that will be bound to each other via a
    // springy effect.
    int boxCount = 15;
    NSMutableArray *boxes;
    
    for( int i = 0; i <= boxCount; i++ )
    {
        // Create the control.
        UIView *square;
        square = [[UIView alloc] initWithFrame:CGRectMake( 20.0f, 20.0f * i, 200.0f, 10.0f)];
        
        // Add it to the array.
        [boxes insertObject:square atIndex:i];
        
        // Create an attachment between it and the previous one if it exists.[
        if( i > 0 )
        {
            // Retrieve the UI Square just behind where this one will go.
            int prevIndex = i - 1;
            UIView *prevSquare = [boxes objectAtIndex:prevIndex];
            
            // Attach them.
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]
                                                initWithItem:square
                                                attachedToAnchor:prevSquare.center];
            
            // Set the damping and other physicsy stuffs.
            [attachment setDamping:0.5f];
            [attachment setFrequency:02.f];
        }
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) numberOfItemsInSection:(NSInteger) section
{
    return 4;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
