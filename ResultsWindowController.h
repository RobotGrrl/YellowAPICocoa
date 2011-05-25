//
//  ResultsWindowController.h
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-05-24.
//  Copyright 2011 robotgrrl.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ResultsWindowController : NSWindowController <NSTableViewDataSource> {

    IBOutlet NSTableView *tableView;

@private
    
}

@end
