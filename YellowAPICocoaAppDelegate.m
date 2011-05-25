//
//  YellowAPICocoaAppDelegate.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-03-12.
//  CC-BY RobotGrrl.com
//

#import "YellowAPICocoaAppDelegate.h"
#import "ResultsWindowController.h"

#define DEBUG YES

@implementation YellowAPICocoaAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
    [whatField setStringValue:@"robots"];
    [whereField setStringValue:@"montreal"];
}

#pragma mark -
#pragma mark Window Related

- (IBAction) searchPressed:(id)sender {
    
    Search *mySearch = [[Search alloc] initWithSearch:@"FindBusiness"];
    [mySearch setWhat:[whatField stringValue]];
    [mySearch setWhere:[whereField stringValue]];
    NSArray *resultingLocations = [mySearch findResults];
    [mySearch release];
    
    NSLog(@"Number of results: %lu", [resultingLocations count]);
    
    Location *l = [resultingLocations objectAtIndex:0];
    //NSLog(@"Location 0: %@", l);
    
    NSString *listing = l.listingID;
    NSString *city = [l city];
    NSString *prov = [l province];
    NSString *name = [l name];    
    
    // We have to unconvert from UTF8 to ASCII, lolz
    [city dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [prov dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [name dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    Search *myGetBusinessDetailsSerach = [[Search alloc] initWithSearch:@"GetBusinessDetails"];
    [myGetBusinessDetailsSerach setBusinessName:name];
    [myGetBusinessDetailsSerach setListingID:listing];
    [myGetBusinessDetailsSerach setCity:city];
    [myGetBusinessDetailsSerach setProv:prov];
    Business *b = [myGetBusinessDetailsSerach findResults];
    [myGetBusinessDetailsSerach release];
    
    NSLog(@"Business: %@", b);
    NSLog(@"City: %@", [b city]);
    
}

@end
