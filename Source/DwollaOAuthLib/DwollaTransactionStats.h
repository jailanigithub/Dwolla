//
//  DwollaTransactionStats.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.m"

@interface DwollaTransactionStats : NSObject

@property (retain) NSString *count;
@property (retain) NSString *total;

/**
 * initializes a new DwollTransactionStats with the given parameters
 *
 * @param success: set to YES if the request was successful 
 * @param count: a string representation of the number of transactions
 * @param image: a string representation of the transactions total
 *
 * @return DwollaContact
 **/
-(id)initWithSuccess:(BOOL)success 
               count:(NSString*)count
               total:(NSString*)total;

-(BOOL)isEqualTo:(DwollaTransactionStats*)_stats;

-(id)initWithDictionary:(NSDictionary*) dictionary;

@end
