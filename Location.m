//
//  Location.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-03-12.
//  CC-BY RobotGrrl.com
//

#import "Location.h"


@implementation Location

@synthesize parentId, isParent, distance;
@synthesize content;
@synthesize listingID, name;
@synthesize address, geoCode;

- (id) init {
	
	if(![super	init])
		return nil;
	
	return self;
	
}

- (NSString *) description {
    
    NSString *desc = [NSString stringWithFormat:@"Name: %@ \nParent ID: %@ \nIs Parent: %d \nDistance: %@ \nContent: %@ \nListing ID %@ \nAddress: %@ \nLat: %@ \nLon: %@",
                      name, parentId, (int)isParent, distance,
                      content, listingID, address, [self latitude], [self longitude]];
    
    return desc;
    
}

#pragma mark -
#pragma mark Content Dict

- (BOOL) dspAdAvail {
    NSDictionary *dspAd = [content objectForKey:@"DspAd"];
    return [[dspAd objectForKey:@"avail"] boolValue];
}

- (BOOL) dspAdInMkt {
    NSDictionary *dspAd = [content objectForKey:@"DspAd"];
    return [[dspAd objectForKey:@"inMkt"] boolValue];
}

- (BOOL) logoAvail {
    NSDictionary *logo = [content objectForKey:@"Logo"];
    return [[logo objectForKey:@"avail"] boolValue];
}

- (BOOL) logoInMkt {
    NSDictionary *logo = [content objectForKey:@"Logo"];
    return [[logo objectForKey:@"inMkt"] boolValue];
}

- (BOOL) photoAvail {
    NSDictionary *photo = [content objectForKey:@"Photo"];
    return [[photo objectForKey:@"avail"] boolValue];
}

- (BOOL) photoInMkt {
    NSDictionary *photo = [content objectForKey:@"Photo"];
    return [[photo objectForKey:@"inMkt"] boolValue];
}

- (BOOL) profileAvail {
    NSDictionary *profile = [content objectForKey:@"Profile"];
    return [[profile objectForKey:@"avail"] boolValue];
}

- (BOOL) profileInMkt {
    NSDictionary *profile = [content objectForKey:@"Profile"];
    return [[profile objectForKey:@"inMkt"] boolValue];
}

- (BOOL) urlAvail {
    NSDictionary *url = [content objectForKey:@"Url"];
    return [[url objectForKey:@"avail"] boolValue];
}

- (BOOL) urlInMkt {
    NSDictionary *url = [content objectForKey:@"Url"];
    return [[url objectForKey:@"inMkt"] boolValue];
}

- (BOOL) videoAvail {
    NSDictionary *video = [content objectForKey:@"Video"];
    return [[video objectForKey:@"avail"] boolValue];
}

- (BOOL) videoInMkt {
    NSDictionary *video = [content objectForKey:@"Video"];
    return [[video objectForKey:@"inMkt"] boolValue];
}

#pragma mark -
#pragma mark Address Dict

- (NSString *) street {
    return [address objectForKey:@"street"];
}

- (NSString *) city { 
    return [address objectForKey:@"city"];
}

- (NSString *) province {
    return [address objectForKey:@"prov"];
}

- (NSString *) pcode {
    return [address objectForKey:@"pcode"];
}

#pragma mark -
#pragma mark Geocode Dict

- (NSString *) latitude {
    return [geoCode objectForKey:@"latitude"];
}

- (NSString *) longitude {
    return [geoCode objectForKey:@"longitude"];
}

#pragma mark -
#pragma mark Mem

- (void) dealloc {
    [parentId release];
    [distance release];
    [content release];
    [listingID release];
    [name release];
    [address release];
    [geoCode release];
    [super dealloc];
}

@end
