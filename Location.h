//
//  Location.h
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-03-12.
//  CC-BY RobotGrrl.com
//

#import <Foundation/Foundation.h>


@interface Location : NSObject {

	NSString *parentId;
	BOOL isParent;
	NSString *distance;
	
	NSDictionary *content;
	
	NSString *listingID; // aka "id"
	NSString *name;
	
	NSDictionary *address;
	NSDictionary *geoCode;
	
}

@property (nonatomic, retain) NSString *parentId;
@property (assign) BOOL isParent;
@property (nonatomic, retain) NSString *distance;

@property (nonatomic, retain) NSDictionary *content;

@property (nonatomic, retain) NSString *listingID; // aka "id"
@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSDictionary *address;
@property (nonatomic, retain) NSDictionary *geoCode;

// Content
- (BOOL) dspAdAvail;
- (BOOL) dspAdInMkt;
- (BOOL) logoAvail;
- (BOOL) logoInMkt;
- (BOOL) photoAvail;
- (BOOL) photoInMkt;
- (BOOL) profileAvail;
- (BOOL) profileInMkt;
- (BOOL) urlAvail;
- (BOOL) urlInMkt;
- (BOOL) videoAvail;
- (BOOL) videoInMkt;

// Address
- (NSString *) street;
- (NSString *) city;
- (NSString *) province;
- (NSString *) pcode;

// Geocode
- (NSString *) latitude;
- (NSString *) longitude;

@end
