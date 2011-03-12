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
#import "Location.h"

@interface YellowAPICocoaAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSArray *resultingLocations;
}

@property (assign) IBOutlet NSWindow *window;

- (void) searchWhat:(NSString *)givenWhat andWhere:(NSString *)givenWhere;
- (void) organizeTheData:(NSDictionary *)resultsDict;

@end
