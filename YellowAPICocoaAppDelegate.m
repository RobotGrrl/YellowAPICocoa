//
//  YellowAPICocoaAppDelegate.m
//  YellowAPICocoa
//
//  Created by Erin Kennedy on 11-03-12.
//  CC-BY RobotGrrl.com
//

#import "YellowAPICocoaAppDelegate.h"

#define DEBUG YES

@implementation YellowAPICocoaAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSLog(@"Welcome!");
    [whatField setStringValue:@"robots"];
    [whereField setStringValue:@"montreal"];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(textDidChange:)
               name:NSTextDidChangeNotification
             object:nil];
    pastInput = @"";
    
}

- (void)textDidChange:(NSNotification *)aNotification {
    
    NSLog(@"Text changed");
    
    NSString *currentInput = [typeAheadField stringValue];
    
    NSString *changeText = [currentInput stringByReplacingOccurrencesOfString:pastInput withString:@""];
    
    if([changeText isEqualToString:@" "]) {
        
        Search *myGetTypeAheadSearch = [[Search alloc] initWithSearch:@"GetTypeAhead"];
        [myGetTypeAheadSearch setField:@"WHAT"];
        [myGetTypeAheadSearch setTypeAheadText:pastInput]; // TODO: This is lazy an will sometimes breaktwi. Should just trim the trailing space off of the current input.
        NSArray *typeAheadResults = [myGetTypeAheadSearch findResults];
        [myGetTypeAheadSearch release];
        NSLog(@"Type ahead: %@", typeAheadResults);
        
    }
    
    pastInput = currentInput;
    
}

- (IBAction) searchPressed:(id)sender {
    
    
    // FindBusiness
    Search *findBusiness = [[Search alloc] initWithSearch:@"FindBusiness"];
    [findBusiness setWhat:[whatField stringValue]];
    [findBusiness setWhere:[whereField stringValue]];
    NSArray *findBusinessLocations = [findBusiness findResults];
    NSDictionary *findBusinessSummary = findBusiness.summary;
    [findBusiness release];
    
    NSLog(@"FindBusiness Summary: %@", findBusinessSummary);
    
    Location *l = [findBusinessLocations objectAtIndex:0];
    NSLog(@"FindBusiness Location #0: %@", l);
    
    NSString *listing = l.listingID;
    NSString *city = [l city];
    NSString *prov = [l province];
    NSString *name = [l name];
    // ---
    
    
    sleep(1);
    
    
    // GetBusinessDetails
    Search *getBusinessDetails = [[Search alloc] initWithSearch:@"GetBusinessDetails"];
    [getBusinessDetails setBusinessName:name];
    [getBusinessDetails setListingID:listing];
    [getBusinessDetails setCity:city];
    [getBusinessDetails setProv:prov];
    Business *b = [getBusinessDetails findResults];
    [getBusinessDetails release];
    
    NSLog(@"GetBusinessDetails Business: %@", b);
    // ---
    
    
    sleep(1);
    
    
    // FindDealer
    Search *findDealer = [[Search alloc] initWithSearch:@"FindDealer"];
    [findDealer setPid:@"6418182"];
    NSArray *findDealerLocations = [findDealer findResults];
    NSDictionary *findDealerSummary = findDealer.summary;
    [findDealer release];
    
    NSLog(@"FindDealer Summary: %@", findDealerSummary);
    
    Location *d = [findDealerLocations objectAtIndex:0];
    NSLog(@"FindDealer Location #0: %@", d);
    // ---
    
    
    sleep(1);
    
    // FindBusiness (Latitude & Longitude)
    Search *findBusinessLL = [[Search alloc] initWithSearch:@"FindBusiness"];
    [findBusinessLL setWhat:@"barber"];
    [findBusinessLL setWhere:@"cZ-73.61995,45.49981"];
    NSArray *findBusinessLLLocations = [findBusinessLL findResults];
    NSDictionary *findBusinessLLSummary = findBusinessLL.summary;
    [findBusinessLL release];
    
    NSLog(@"FindBusiness LL Summary: %@", findBusinessLLSummary);
    
    Location *ll = [findBusinessLLLocations objectAtIndex:0];
    NSLog(@"FindBusiness LL Location #0: %@", ll);
    // ---
    
    sleep(1);
    
}

@end
