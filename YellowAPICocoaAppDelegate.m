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

#pragma mark -
#pragma mark Window Related

- (IBAction) searchPressed:(id)sender {
    
    Search *mySearch = [[Search alloc] initWithSearch:@"FindBusiness"];
    [mySearch setWhat:[whatField stringValue]];
    [mySearch setWhere:[whereField stringValue]];
    NSArray *resultingLocations = [mySearch findResults];
    [mySearch release];
    
    NSLog(@"Number of results: %lu", [resultingLocations count]);
    
    Location *l = [resultingLocations objectAtIndex:0];
    NSLog(@"Location 0: %@", l);
    
    NSString *listing = l.listingID;
    NSString *city = [l city];
    NSString *prov = [l province];
    NSString *name = [l name];    
    
    // We have to unconvert from UTF8 to ASCII, lolz
    //[city dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //[prov dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //[name dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    sleep(1);
    
    Search *myGetBusinessDetailsSerach = [[Search alloc] initWithSearch:@"GetBusinessDetails"];
    [myGetBusinessDetailsSerach setBusinessName:name];
    [myGetBusinessDetailsSerach setListingID:listing];
    [myGetBusinessDetailsSerach setCity:city];
    [myGetBusinessDetailsSerach setProv:prov];
    Business *b = [myGetBusinessDetailsSerach findResults];
    [myGetBusinessDetailsSerach release];
    
    NSLog(@"Business: %@", b);
    
    sleep(1);
    
    Search *myFindDealerSearch = [[Search alloc] initWithSearch:@"FindDealer"];
    [myFindDealerSearch setPid:@"6418182"];
    NSArray *resultingDealers = [myFindDealerSearch findResults];
    [myFindDealerSearch release];
    
    Location *d = [resultingDealers objectAtIndex:0];
    NSLog(@"Dealer: %@", d);
    
}

@end
