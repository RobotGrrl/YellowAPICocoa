//
//  Search.h
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-05-24.
//  Copyright 2011 robotgrrl.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "Location.h"
#import "Business.h"

#define APIKEY @"ww944532t26x6upk9yhv5qh4"
#define UID @"1337"
#define APIURL @"http://api.sandbox.yellowapi.com/"

@interface Search : NSObject {
    
    // All
    NSString *lang;         // (N) en (default) or fr
    NSString *fmt;          // (N) JSON or XML (default)
    int pg;                 // (N) Default: 1 Max: 50 Integer > 0 (FindBusiness & FindDealer)
    int pgLen;              // (N) Default: 40 Max: 100 Integer > 0 (FindBusiness & FindDealer)
    
    // FindBusiness
	NSString *what;         // (Y)
	NSString *where;        // (Y) Location name or cZ{longitude},{latitude}
	NSString *sflag;        // (N) Search filter- bn/fto/vdo
    
    // GetBusinessDetails
    NSString *prov;         // (Y) If not available, use "Canada"
    NSString *city;         // (N)
    NSString *busName;      // (Y) Business name, normalized
    NSString *listingID;    // (Y)
    
    // FindDealer
    NSString *pid;          // (Y) Listing ID of a parent business (you can tell if it is a parent by the isParent flag in FindBusiness)
    
    // GetTypeAhead
    NSString *typeAheadText;
    NSString *field;
    
@private
    
    NSString *searchType;
    
}

- (id) initWithSearch:(NSString *)s;
- (id) findResults;

// All
@property (nonatomic, retain) NSString *lang;
@property (nonatomic, retain) NSString *fmt;

// FindBusiness
@property (assign) int pg;
@property (assign) int pgLen;
@property (nonatomic, retain) NSString *sflag;

- (void) setWhat:(NSString *)w;
- (void) setWhere:(NSString *)w;

// GetBusinessDetails
@property (nonatomic, retain) NSString *prov;
@property (nonatomic, retain) NSString *listingID;

- (void) setBusinessName:(NSString *)b;
- (void) setCity:(NSString *)c;

// FindDealer
@property (nonatomic, retain) NSString *pid;

// GetTypeAhead
@property (nonatomic, retain) NSString *typeAheadText;
@property (nonatomic, retain) NSString *field;

@end

/*
 TODO: Need to make location name able to have lat,lon input
 */
