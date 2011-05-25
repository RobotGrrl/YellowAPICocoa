//
//  YellowAPICocoaAppDelegate.h
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-03-12.
//  CC-BY RobotGrrl.com
//

// http://www.yellowapi.ca

#import <Cocoa/Cocoa.h>
#import "JSON.h"
#import "Search.h"
#import "Location.h"
#import "Business.h"

@class ResultsWindowController;

@interface YellowAPICocoaAppDelegate : NSObject <NSApplicationDelegate> {
    
    // IB
    NSWindow *window;
    IBOutlet NSTextField *whatField;
    IBOutlet NSTextField *whereField;
    IBOutlet NSProgressIndicator *progressInd;
    ResultsWindowController *resultsWindow;
    
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) searchPressed:(id)sender;

@end
