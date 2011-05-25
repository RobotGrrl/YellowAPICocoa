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
    
    NSString *desc = [NSString stringWithFormat:@"Name: %@ \nParent ID: %@ \nIs Parent: %d \nDistance: %@ \nContent: %@ \nListing ID %@ \nAddress: %@ \nGeocode: %@",
                      name, parentId, (int)isParent, distance,
                      content, listingID, address, geoCode];
    
    return desc;
    
}

- (NSString *) city { 
    return [address objectForKey:@"city"];
}

- (NSString *) province {
    return [address objectForKey:@"prov"];
}

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
