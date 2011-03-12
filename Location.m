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

@end
