//
//  Business.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-05-24.
//  Copyright 2011 robotgrrl.com. All rights reserved.
//

#import "Business.h"


@implementation Business

@synthesize address, categories, geocode, listingId;
@synthesize logos, merchantURL, name, phones, products;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString *) description {
    
    NSString *desc = [NSString stringWithFormat:@"Address: %@ \nCategories: %@ \nGeoCode: %@ \nListing ID: %@ \nLogos: %@ \nMerchant URL: %@ \nName: %@ \nPhones: %@ \nProducts: %@\n", 
                      address, categories, geocode, listingId, logos,
                      merchantURL, name, phones, products];
    
    return desc;
    
}

#pragma mark -
#pragma mark Address

- (NSString *) city {
    if(address == nil) return nil;
    NSString *c = [address objectForKey:@"city"];
    return c;
}



- (void)dealloc {
    [address release];
    [categories release];
    [geocode release];
    [listingId release];
    [logos release];
    [merchantURL release];
    [name release];
    [phones release];
    [products release];
    [super dealloc];
}

@end
