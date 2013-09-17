//
//  DwollaFundingSources.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DwollaFundingSource.h"

@interface DwollaFundingSources : NSObject
{
    BOOL success;
    NSMutableArray* sources;
}

/**
 * initializes a DwollaFundingSources object with the given parameters
 *
 * @param success: set to YES if the request was successful 
 * @param sources: an array of type DwollaFundingSource
 *
 * @return a DwollaFundingSources object
 **/
-(id)initWithSuccess:(BOOL)success 
            sources:(NSMutableArray*)sources;

/**
 * @return success
 **/
-(BOOL)getSuccess;

/**
 * @return sources
 **/
-(NSMutableArray*)getAll;

/**
 * alphabetizes the sources array
 *
 * @param direction: defaults to ascending order, will only be descending when declared @"DESC"
 *
 * @return sources
 **/
-(NSMutableArray*)getAlphabetized:(NSString*)direction;

/**
 * @param index: the index of the object to be returned
 *
 * @return DwollaContact at the given index
 **/
-(DwollaFundingSource*)getObjectAtIndex:(int)index;

/**
 * @return count of objects in sources
 **/
-(int)count;

-(BOOL)isEqualTo:(DwollaFundingSources*)_sources;

@end
