//
//  Business.h
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-05-24.
//  Copyright 2011 robotgrrl.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Business : NSObject {
    
    NSDictionary *address;
    NSDictionary *categories;
    NSDictionary *geocode;
    NSString *listingId;
    NSArray *logos;
    NSString *merchantURL;
    NSString *name;
    NSArray *phones;
    NSDictionary *products;
    
@private
    
}

@property (nonatomic, retain) NSDictionary *address;
@property (nonatomic, retain) NSDictionary *categories;
@property (nonatomic, retain) NSDictionary *geocode;
@property (nonatomic, retain) NSString *listingId;
@property (nonatomic, retain) NSArray *logos;
@property (nonatomic, retain) NSString *merchantURL;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *phones;
@property (nonatomic, retain) NSDictionary *products;

// Address
- (NSString *) city;

@end
