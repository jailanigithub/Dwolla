//
//  DwollaTransaction.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyclearingDate__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.m"

@interface DwollaTransaction : NSObject

@property (retain) NSString *amount;
@property (retain) NSString *clearingDate;
@property (retain) NSString *date;
@property (retain) NSString *destinationID;
@property (retain) NSString *destinationName;
@property (retain) NSString *transactionID;
@property (retain) NSString *notes;
@property (retain) NSString *sourceID;
@property (retain) NSString *sourceName;
@property (retain) NSString *status;
@property (retain) NSString *type;
@property (retain) NSString *userType;


/**
 * initializes a new DwollaTransaction with the given parameters
 *
 * @param amount: a string representation of the transaction's amount
 * @param clearingDate: a string representation of the transaction's clearingDate
 * @param date: a string representation of the transaction's date
 * @param destinationID: a string representation of the transaction's destinationID
 * @param destinationName: a string representation of the transaction's destinationName
 * @param transactionID: a string representation of the transaction's transactionID
 * @param notes: a string representation of the transaction's notes
 * @param sourceID: a string representation of the transaction's sourceID
 * @param sourceName: a string representation of the transaction's sourceName
 * @param status: a string representation of the transaction's status
 * @param type: a string representation of the transaction's type
 * @param userType: a string representation of the transaction's userType
 *
 * @return DwollaTransaction
 **/
-(id)initWithAmount:(NSString*)amount
       clearingDate:(NSString*)clearingDate
               date:(NSString*)date
      destinationID:(NSString*)destinationID 
    destinationName:(NSString*)destinationName 
      transactionID:(NSString*)transactionID 
              notes:(NSString*)notes 
           sourceID:(NSString*)sourceID
         sourceName:(NSString*)sourceName 
             status:(NSString*)status 
               type:(NSString*)type 
           userType:(NSString*)userType;

-(id)initWithDictionary:(NSDictionary*) dictionary;

-(BOOL)isEqualTo:(DwollaTransaction*)_transaction;

@end
