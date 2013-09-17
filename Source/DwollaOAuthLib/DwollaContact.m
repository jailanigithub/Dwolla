//
//  DwollaContact.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaContact.h"

@implementation DwollaContact

@synthesize userID, name, image, city, state, type, address, longitude, latitude;

-(id)initWithUserID:(NSString*)_userID 
               name:(NSString*)_name
              image:(NSString*)_image 
               city:(NSString*)_city 
              state:(NSString*)_state 
               type:(NSString*)_type
            address:(NSString*)_address
          longitude:(NSString *)_longitude
           latitude:(NSString *)_latitude
{
    self = [super init];
    if (self)
    {
        userID = [_userID retain];
        name = [_name retain];
        image = [_image retain];
        city = [_city retain];
        state = [_state retain];
        type = [_type retain];
        address = [_address retain];
        longitude = [_longitude retain];
        latitude = [_latitude retain];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    if (self)
    {
        userID = [[dictionary objectForKey:ID_RESPONSE_NAME] retain];
        name = [[dictionary objectForKey:NAME_RESPONSE_NAME] retain];
        image = [[dictionary objectForKey:IMAGE_RESPONSE_NAME] retain];
        city = [[dictionary objectForKey:CITY_RESPONSE_NAME] retain];
        state = [[dictionary objectForKey:STATE_RESPONSE_NAME] retain];
        type = [[dictionary objectForKey:TYPE_RESPONSE_NAME] retain];
        address = [[dictionary objectForKey:ADDRESS_RESPONSE_NAME] retain];
        longitude = [[dictionary objectForKey:LONGITUDE_PARAMETER_NAME] retain];
        latitude = [[dictionary objectForKey:LATITUDE_RESPONSE_NAME] retain];
    }
    return self;
}

-(BOOL) isEqualTo:(DwollaContact*)_contact
{
    if (![name isEqualToString:[_contact name]] ||
        ![userID isEqualToString:[_contact userID]] ||
        ![type isEqualToString:[_contact type]])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void) dealloc {
    [userID release];
    [name release];
    [image release];
    [city release];
    [state release];
    [type release];
    [address release];
    [longitude release];
    [latitude release];
    [super dealloc];
}

@end
