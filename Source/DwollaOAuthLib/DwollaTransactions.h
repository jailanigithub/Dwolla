//
//  DwollaTransactions.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DwollaTransaction.h"

@interface DwollaTransactions : NSObject
{
    BOOL success;
    NSMutableArray* transactions;
}

-(id)initWithSuccess:(BOOL)success 
        transactions:(NSMutableArray*)transactions;

/**
 * @return success
 **/
-(BOOL)getSuccess;

/**
 * @return transactions
 **/
-(NSMutableArray*)getAll;

/**
 * @param index: the index of the object to be returned
 *
 * @return DwollaTransaction at the given index
 **/
-(DwollaTransaction*)getObjectAtIndex:(int)index;

/**
 * @return count of objects in transactions
 **/
-(int)count;

-(BOOL)isEqualTo:(DwollaTransactions*)_transactions;

@end
