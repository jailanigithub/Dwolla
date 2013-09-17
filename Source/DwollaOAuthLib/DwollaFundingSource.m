//
//  DwollaFundingSource.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaFundingSource.h"

@implementation DwollaFundingSource

@synthesize sourceID, name, type, verified;

-(id)initWithSourceID:(NSString*)_sourceID 
                 name:(NSString*)_name 
                 type:(NSString*)_type 
             verified:(NSString*)_verified
{
    if (self) 
    {
        sourceID = _sourceID;
        name = _name;
        type = _type;
        verified = [_verified isEqualToString:@"true"];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    if (self)
    {
        sourceID = [dictionary objectForKey:ID_RESPONSE_NAME];
        name = [dictionary objectForKey:NAME_RESPONSE_NAME];
        type = [dictionary objectForKey:TYPE_RESPONSE_NAME];
        verified = [[dictionary objectForKey:VERIFIED_RESPONSE_NAME] isEqualToString:@"true"];
    }
    return self;
}

-(BOOL)isEqualTo:(DwollaFundingSource*)_source
{
    if (![sourceID isEqualToString:[_source sourceID]] || ![name isEqualToString:[_source name]] || ![type isEqualToString:[_source type]] || verified != [_source isVerified])
    {
        return NO;
    }
    else 
    {
        return YES;
    } 
}
@end
