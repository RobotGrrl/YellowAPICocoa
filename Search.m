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
#define kFindDealer @"FindDealer"
#define kGetTypeAhead @"GetTypeAhead"

@interface Search()
- (NSString *)cleanString:(NSString *)s;
- (NSArray *) searchWhat;
- (NSArray *) organizeFindBusiness:(NSDictionary *)resultsDict;
- (Business *) searchBusiness;
- (Business *) organizeGetBusinessDetails:(NSDictionary *)resultsDict;
- (NSArray *) searchDealer;
- (NSArray *) organizeTypeAhead:(NSArray *)resultsArray;
- (NSArray *) searchTypeAhead;
@end

@implementation Search

@synthesize lang, fmt;
@synthesize pg, pgLen, sflag;
@synthesize prov, listingID;
@synthesize pid;
@synthesize typeAheadText, field;
@synthesize summary;

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
        pg = 1;
        pgLen = 10;
        
        if([s isEqualToString:kFindBusiness]) {
            
            searchType = kFindBusiness;
            
            what = @"";
            where = @"";
            sflag = @"";
            
        } else if([s isEqualToString:kGetBusinessDetails]) {
         
            searchType = kGetBusinessDetails;
            
            prov = @"Canada";
            city = @"";
            busName = @"";
            listingID = @"";
            
        } else if([s isEqualToString:kFindDealer]) {
            
            searchType = kFindDealer;
            pid = @"";
            
        } else if([s isEqualToString:kGetTypeAhead]) {
            
            searchType = kGetTypeAhead;
            typeAheadText = @"";
            field = @"";
            
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
    } else if([searchType isEqualToString:kFindDealer]) {
        return [self searchDealer];
    } else if([searchType isEqualToString:kGetTypeAhead]) {
        return [self searchTypeAhead];
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
    
    if([w hasPrefix:@"cZ"]) {
        where = w;
    } else {
        where = [[self cleanString:w] retain];
    }
}

- (NSArray *) organizeFindBusiness:(NSDictionary *)resultsDict {
	    
    summary = [resultsDict objectForKey:@"summary"];
    
	NSArray *listings = [resultsDict objectForKey:@"listings"];
	NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:[listings count]];
    
    for(int i=0; i<[listings count]; i++) {
	//for(int i=[listings count]-1; i>0; i--) {
        
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

// FindDealer

- (NSArray *) organizeFindDealer:(NSDictionary *)resultsDict {
    
    summary = [resultsDict objectForKey:@"summary"];
        
	NSArray *listings = [resultsDict objectForKey:@"listings"];
	NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:[listings count]];
    
    for(int i=0; i<[listings count]; i++) {
	//for(int i=[listings count]-1; i>0; i--) {
        
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

// GetTypeAhead

- (NSArray *) organizeTypeAhead:(NSArray *)resultsArray {
    
    NSMutableArray *types = [[NSMutableArray alloc] initWithCapacity:[resultsArray count]];
    
    for(int i=0; i<[resultsArray count]; i++) {
    
        NSDictionary *result = [resultsArray objectAtIndex:i];
        NSString *value = [result objectForKey:@"value"];
        [types addObject:value];
        
    }
    
    return [NSArray arrayWithArray:types];
    
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

- (NSArray *) searchDealer {
    NSString *url = [NSString stringWithFormat:@"%@FindDealer/?pid=%@&pg=%d&pgLen=%d&lang=%@&fmt=%@&apikey=%@&UID=%@", APIURL, pid, pg, pgLen, lang, fmt, APIKEY, UID];
	if(DEBUG) NSLog(@"FindDealer URL: %@", url);
	
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
        if(resultsDict != nil) return [self organizeFindDealer:resultsDict];
	}
    
    return nil;
    
}

- (NSArray *) searchTypeAhead {
    NSString *url = [NSString stringWithFormat:@"%@GetTypeAhead/?text=%@&lang=%@&field=%@&apikey=%@&UID=%@", APIURL, typeAheadText, lang, field, APIKEY, UID];
	if(DEBUG) NSLog(@"GetTypeAhead URL: %@", url);
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	NSArray *resultsArray = [parser objectWithString:json_string error:&error];
	
    [parser release];
	[json_string release];
    
	if(error) {
		NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
		NSLog(@"Error... %@", errorStr);
	} else {
        if(resultsArray != nil) return [self organizeTypeAhead:resultsArray];
	}
    
    return nil;
    
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc {
    [lang release];
    [fmt release];
    [sflag release];
    [prov release];
    [listingID release];
    [pid release];
    [typeAheadText release];
    [field release];
    //if(summary != nil) [summary release]; // TODO: Fix this >_<
    [super dealloc];
}

@end
