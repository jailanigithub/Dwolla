//
//  DwollaContact.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.m"

@interface DwollaContact : NSObject

    @property (retain) NSString *userID;
    @property (retain) NSString *name;
    @property (retain) NSString *image;
    @property (retain) NSString *city;
    @property (retain) NSString *state;
    @property (retain) NSString *type;
    @property (retain) NSString *address;
    @property (retain) NSString *longitude;
    @property (retain) NSString *latitude;

/**
 * initializes a new DwollaContact with the given parameters
 *
 * @param userID: a string representation of the contact's userID
 * @param name: a string representation of the contact's name
 * @param image: a string representation of the contact's image
 * @param city: a string representation of the contact's city
 * @param state: a string representation of the contact's state
 * @param type: a string representation of the contact's type
 *
 * @return DwollaContact
 **/
-(id)initWithUserID:(NSString*)userID 
               name:(NSString*)name
              image:(NSString*)image 
               city:(NSString*)city 
              state:(NSString*)state 
               type:(NSString*)type
            address:(NSString*)address
          longitude:(NSString*)longitude
           latitude:(NSString*)latitude;

-(id)initWithDictionary:(NSDictionary*)dictionary;

-(BOOL) isEqualTo:(DwollaContact*)_contact;

@end
