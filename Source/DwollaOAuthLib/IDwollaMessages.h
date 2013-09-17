//
//  IDwollaMessages.h
//  DwollaSDK
//
//  Created by Nick Schulze on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDwollaMessages

/**
 * called in the case of a successful login
 **/
-(void)successfulLogin;

/**
 * called in the case of a failed login
 **/
-(void)failedLogin:(NSArray*)errors;


@end
