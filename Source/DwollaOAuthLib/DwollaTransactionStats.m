//
//  DwollaTransactionStats.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaTransactionStats.h"

@implementation DwollaTransactionStats

@synthesize count, total;

-(id)initWithSuccess:(BOOL)_success 
               count:(NSString*)_count 
               total:(NSString*)_total
{
    if (self) 
    {
        count = _count;
        total = _total;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*) dictionary
{
    if (self)
    {
        count = [dictionary valueForKey:TRANSACTION_COUNT_RESPONSE_NAME];
        total = [dictionary valueForKey:TRANSACTION_TOTAL_RESPONSE_NAME];
    }
    return self;
}

-(BOOL)isEqualTo:(DwollaTransactionStats*)_stats
{
    if (![count isEqualToString:[_stats count]] || ![total isEqualToString:[_stats total]])
    {
        return NO;
    }
    else 
    {
        return YES;
    } 
}

@end
