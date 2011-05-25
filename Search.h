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
    NSString *lang; // en - English (default), fr - French (N)
    NSString *fmt; // JSON or XML (default) (N)

    // FindBusiness
	int pg; // Default: 1 Max: 50 Integer > 0 (N)
	NSString *what; // (Y)
	NSString *where; // Location name or cZ{longitude},{latitude} (Y)
    int pgLen; // Default: 40 Max: 100 Integer > 0 (N)
	NSString *sflag; // Search filter- bn/fto/vdo (N)
    
    // GetBusinessDetails
    NSString *prov; // If not available, use "Canada" (Y)
    NSString *city; // (N)
    NSString *busName; // Business name, normalized (Y)
    NSString *listingID; // (Y)

    
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

@end

/*
 TODO: Need to make location name able to have lat,lon input
 */
