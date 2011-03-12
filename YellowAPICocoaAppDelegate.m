//
//  YellowAPICocoaAppDelegate.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-03-12.
//  CC-BY RobotGrrl.com
//

#import "YellowAPICocoaAppDelegate.h"

#define APIKEY @"ww944532t26x6upk9yhv5qh4"
#define UID @"1337"
#define DEBUG YES

@implementation YellowAPICocoaAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	[self searchWhat:@"robot" andWhere:@"canada"];
}

- (void) searchWhat:(NSString *)givenWhat andWhere:(NSString *)givenWhere {

	if(DEBUG) NSLog(@"Searching what (%@) & where (%@)", givenWhat, givenWhere);
	
	int pg = 1; // Default: 1 Max: 50 Integer > 0
	NSString *what = [[NSString alloc] initWithCString:[givenWhat UTF8String]]; // Non-ASCII characters should be UTF-8 encoded
	NSString *lang = @"en"; // en - English (default), fr - French
	NSString *where = [[NSString alloc] initWithCString:[givenWhere UTF8String]]; // Location name or cZ{longitude},{latitude} (Non-ASCII characters should be UTF-8 encoded)
	int pgLen = 10; // Default: 40 Max: 100 Integer > 0
	NSString *fmt = @"JSON"; // JSON or XML (default)
	NSString *sflag = @""; // Search filter- bn/fto/vdo
	
	NSString *url = [NSString stringWithFormat:@"http://api.sandbox.yellowapi.com/FindBusiness/?pg=%d&what=%@&where=%@&pgLen=%d&lang=%@&fmt=%@&sflag=%@&apikey=%@&UID=%@", pg, what, where, pgLen, lang, fmt, sflag, APIKEY, UID];
	if(DEBUG) NSLog(@"The URL: %@", url);
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	NSDictionary *resultsDict = [parser objectWithString:json_string error:&error];
	[parser release];
	
	[what release];
	[where release];
	
	if(error) {
		NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
		NSLog(@"Error... %@", errorStr);
	}
	
	if(!error) {
		[self organizeTheData:resultsDict];
	}
	
}

- (void) organizeTheData:(NSDictionary *)resultsDict {

	if(DEBUG) NSLog(@"Organizing the data");
	
	NSMutableArray *listings = [resultsDict objectForKey:@"listings"];
	
	for(int i=[listings count]-1; i>0; i--) {
	
		NSDictionary *placeObject = [listings objectAtIndex:i];
		
		Location *newLocation = [[Location alloc] init];
		newLocation.parentId = [placeObject objectForKey:@"parentId"];
		newLocation.isParent = [[placeObject objectForKey:@"isParent"] boolValue];
		newLocation.distance = [placeObject objectForKey:@"distance"];
		newLocation.content = [placeObject objectForKey:@"content"];
		newLocation.listingID = [placeObject objectForKey:@"id"];
		newLocation.name = [placeObject objectForKey:@"name"];
		newLocation.address = [placeObject objectForKey:@"address"];
		newLocation.geoCode = [placeObject objectForKey:@"geoCode"];
		
		[listings addObject:newLocation];
		[newLocation release];
		
	}
	
	if(DEBUG) NSLog(@"Listing 0: %@", [listings objectAtIndex:0]);
	
}

@end
