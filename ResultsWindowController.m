//
//  ResultsWindowController.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-05-24.
//  Copyright 2011 robotgrrl.com. All rights reserved.
//

#import "ResultsWindowController.h"


@implementation ResultsWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        NSLog(@"Results window is here");
        [self showWindow:self];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 5;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return @"yay";
}

@end
