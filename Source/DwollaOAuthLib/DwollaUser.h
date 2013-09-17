//
//  DwollaUser.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.m"

@interface DwollaUser : NSObject
    @property (retain) NSString *userID;
    @property (retain) NSString *name;
    @property (retain) NSString *city;
    @property (retain) NSString *state;
    @property (retain) NSString *longitude;
    @property (retain) NSString *latitude;
    @property (retain) NSString *type;

/**
 * initializes a new DwollaUser with the given parameters
 *
 * @param userID: a string representation of the user's userID
 * @param name: a string representation of the user's name
 * @param city: a string representation of the user's city
 * @param state: a string representation of the user's state
 * @param city: a string representation of the user's latitude
 * @param state: a string representation of the user's longitude
 * @param type: a string representation of the user's type
 *
 * @return DwollaUser
 **/
-(id)initWithUserID:(NSString*)userID 
               name:(NSString*)name 
               city:(NSString*)city 
              state:(NSString*)state 
           latitude:(NSString*)latitude 
          longitude:(NSString*)longitude 
               type:(NSString*)type;

-(id)initWithDictionary:(NSDictionary*) dictionary;

-(BOOL)isEqualTo:(DwollaUser*)_user;

@end
