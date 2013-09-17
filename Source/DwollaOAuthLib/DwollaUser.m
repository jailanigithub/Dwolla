//
//  DwollaUser.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaUser.h"

@implementation DwollaUser

@synthesize userID, name, city, state, latitude, longitude, type;

-(id)initWithUserID:(NSString*)_userID name:(NSString*)_name city:(NSString*)_city state:(NSString*)_state 
           latitude:(NSString*)_latitude longitude:(NSString*)_longitude type:(NSString*)_type
{
    self = [super init];
    if (self) 
    {
        userID = [_userID retain];
        name = [_name retain];
        city = [_city retain];
        state = [_state retain];
        latitude = [_latitude retain];
        longitude = [_longitude retain];
        type = [_type retain];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    if (self)
    {
        userID = [[dictionary valueForKey:ID_RESPONSE_NAME] retain];
        name = [[dictionary valueForKey:NAME_RESPONSE_NAME] retain];
        city = [[dictionary valueForKey:CITY_RESPONSE_NAME] retain];
        state = [[dictionary valueForKey:STATE_RESPONSE_NAME] retain];
        latitude = [[dictionary valueForKey:LATITUDE_RESPONSE_NAME] retain];
        longitude = [[dictionary valueForKey:LONGITUDE_RESPONSE_NAME] retain];
        type = [[dictionary valueForKey:TYPE_RESPONSE_NAME] retain];
    }
    return self;
}

-(BOOL)isEqualTo:(DwollaUser*)_user
{
    if ([name isEqualToString:[_user name]] || [userID isEqualToString:[_user userID]] || ((type == nil && [_user type] == nil) || [userID isEqualToString:[_user userID]]))
        return YES;

    return NO;
}

-(void) dealloc {
    [userID release];
    [name release];
    [city release];
    [state release];
    [latitude release];
    [longitude release];
    [type release];
    [super dealloc];
}

@end
