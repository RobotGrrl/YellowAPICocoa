//
//  Search.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-05-24.
//  Copyright 2011 robotgrrl.com. All rights reserved.
//

#import "Search.h"

#define DEBUG YES

#define kFindBusiness @"FindBusiness"
#define kGetBusinessDetails @"GetBusinessDetails"

@interface Search()
- (NSString *)cleanString:(NSString *)s;
- (NSArray *) searchWhat;
- (Business *) searchBusiness;
- (Business *) organizeGetBusinessDetails:(NSDictionary *)resultsDict;
@end

@implementation Search

@synthesize lang, fmt;
@synthesize pg, pgLen, sflag;
@synthesize prov, listingID;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initWithSearch:(NSString *)s {
    self = [super init];
    if(self) {
        
        lang = @"en";
        fmt = @"JSON";
        
        if([s isEqualToString:kFindBusiness]) {
            
            searchType = kFindBusiness;
            
            pg = 1;
            what = @"";
            where = @"";
            pgLen = 10;
            sflag = @"";
            
        } else if([s isEqualToString:kGetBusinessDetails]) {
         
            searchType = kGetBusinessDetails;
            
            prov = @"Canada";
            city = @"";
            busName = @"";
            listingID = @"";
            
        }
        
    }
    
    return self;
    
}

- (NSString *)cleanString:(NSString *)s {
    
    // Removing the spaces
    NSCharacterSet *charactersToRemove = [[ NSCharacterSet alphanumericCharacterSet ] invertedSet ];
    NSString *tempRemoved = [[s componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@"-"];
    
    // Making non-ASCII characters UTF-8 encoded
    //NSString *tempUTF8 = [[NSString alloc] initWithCString:[tempRemoved UTF8String]];
    NSString *tempUTF8 = [[[NSString alloc] initWithData:[tempRemoved dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES] encoding:NSASCIIStringEncoding] autorelease];
    
    return tempUTF8;

}

- (id) findResults {
    
    if([searchType isEqualToString:kFindBusiness]) {
        return [self searchWhat];
    } else if([searchType isEqualToString:kGetBusinessDetails]) {
        return [self searchBusiness];
    }
    
    return nil;
    
}

#pragma mark -
#pragma mark Formatting & Processing

// FindBusiness

- (void) setWhat:(NSString *)w {
    [what autorelease];
    what = [[self cleanString:w] retain];
}

- (void) setWhere:(NSString *)w {
    [where autorelease];
    where = [[self cleanString:w] retain];
}

- (NSArray *) organizeFindBusiness:(NSDictionary *)resultsDict {
	
	NSArray *listings = [resultsDict objectForKey:@"listings"];
	NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:[listings count]];
    
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
		
		[locations addObject:newLocation];
		[newLocation release];
		
	}
    
    return [NSArray arrayWithArray:locations];
    
}

// GetBusinessDetails

- (void) setBusinessName:(NSString *)b {
    [busName autorelease];
    busName = [[self cleanString:b] retain];
}

- (void) setCity:(NSString *)c {
    [city autorelease];
    city = [[self cleanString:c] retain];
}

- (Business *) organizeGetBusinessDetails:(NSDictionary *)resultsDict {
    
    Business *newBusiness = [[Business alloc] init];
    
    newBusiness.address = [resultsDict objectForKey:@"address"];
    newBusiness.categories = [resultsDict objectForKey:@"categories"];
    newBusiness.geocode = [resultsDict objectForKey:@"geocode"];
    newBusiness.listingId = [resultsDict objectForKey:@"id"];
    newBusiness.logos = [resultsDict objectForKey:@"logos"];
    newBusiness.merchantURL = [resultsDict objectForKey:@"merchantUrl"];
    newBusiness.name = [resultsDict objectForKey:@"name"];
    newBusiness.phones = [resultsDict objectForKey:@"phones"];
    newBusiness.products = [resultsDict objectForKey:@"products"];
    
    return newBusiness;
    
}

#pragma mark -
#pragma mark YellowAPI

- (NSArray *) searchWhat {
    NSString *url = [NSString stringWithFormat:@"%@FindBusiness/?pg=%d&what=%@&where=%@&pgLen=%d&lang=%@&fmt=%@&sflag=%@&apikey=%@&UID=%@", APIURL, pg, what, where, pgLen, lang, fmt, sflag, APIKEY, UID];
	if(DEBUG) NSLog(@"FindBusiness URL: %@", url);
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	NSDictionary *resultsDict = [parser objectWithString:json_string error:&error];
	
    [parser release];
	[json_string release];
    
	if(error) {
		NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
		NSLog(@"Error... %@", errorStr);
	} else {
        if(resultsDict != nil) return [self organizeFindBusiness:resultsDict];
	}
    
    return nil;
    
}

- (Business *) searchBusiness {
    
    if(DEBUG) NSLog(@"Searching business: %@ with ID: %@ in province: %@ in city: %@", busName, listingID, prov, city);
    
	NSString *url = [NSString stringWithFormat:@"%@GetBusinessDetails/?prov=%@&city=%@&bus-name=%@&listingId=%@&lang=%@&fmt=%@&apikey=%@&UID=%@", APIURL, prov, city, busName, listingID, lang, fmt, APIKEY, UID];
	if(DEBUG) NSLog(@"Search business URL: %@", url);
    
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	NSDictionary *resultsDict = [parser objectWithString:json_string error:&error];
	[parser release];
	
	if(error) {
		//NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
		NSLog(@"Error... %@", [error userInfo]);
        return nil;
	} else {
        if(resultsDict != nil) return [self organizeGetBusinessDetails:resultsDict];
	}
    
    return nil;
    
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc {
    [super dealloc];
}

@end
