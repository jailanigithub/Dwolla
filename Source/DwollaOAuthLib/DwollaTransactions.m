//
//  DwollaTransactions.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaTransactions.h"

@implementation DwollaTransactions

-(id)initWithSuccess:(BOOL)_success 
        transactions:(NSMutableArray*)_transactions
{
    if (self)
    {
        success = _success;
        transactions = _transactions;
    }
    return self;
}

-(NSMutableArray*)getAll
{
    return transactions;
}

-(BOOL)getSuccess
{
    return success;
}

-(int)count
{
    return [transactions count];
}

-(DwollaTransaction*)getObjectAtIndex:(int)index
{
    return [transactions objectAtIndex:index];
}

-(BOOL)isEqualTo:(DwollaTransactions*)_transactions
{
    if ([_transactions count] == [transactions count]) 
    {
        for (int i = 0; i < [transactions count]; i++) 
        {
            if (![[_transactions getObjectAtIndex:i] isEqualTo: [transactions objectAtIndex:i]]) 
            {
                return NO;
            }
        }
    }
    else 
    {
        return NO;
    }
    return YES;
}

@end
