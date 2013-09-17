//
//  DwollaFundingSource.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.m"

@interface DwollaFundingSource : NSObject

    @property (retain) NSString *sourceID;
    @property (retain) NSString *name;
    @property (retain) NSString *type;
    @property (nonatomic, assign, getter = isVerified) BOOL verified;

/**
 * initializes a new DwollaFundingSource with the given parameters
 *
 * @param sourceID: a string representation of the funding source's userID
 * @param name: a string representation of the funding source's name
 * @param type: a string representation of the funding source's type
 * @param verified: a string representation of the funding source's current status
 *
 * @return DwollaFundingSource
 **/
-(id)initWithSourceID:(NSString*)sourceID 
                 name:(NSString*)name 
                 type:(NSString*)type 
             verified:(NSString*)verified;

-(id)initWithDictionary:(NSDictionary*)dictionary;

-(BOOL)isEqualTo:(DwollaFundingSource*)_source;

@end
