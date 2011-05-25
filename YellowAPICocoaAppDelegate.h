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

@interface YellowAPICocoaAppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate> {
    
    // IB
    NSWindow *window;
    IBOutlet NSTextField *whatField;
    IBOutlet NSTextField *whereField;
    IBOutlet NSProgressIndicator *progressInd;
    IBOutlet NSTextField *typeAheadField;
    
    NSString *pastInput;
    
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) searchPressed:(id)sender;

@end
