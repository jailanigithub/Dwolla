//
//  DwollaTransaction.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaTransaction.h"

@implementation DwollaTransaction

@synthesize amount, clearingDate, date, destinationID, destinationName, transactionID, notes, sourceID, sourceName, status, type, userType;

-(id)initWithAmount:(NSString*)_amount
       clearingDate:(NSString*)_clearingDate
               date:(NSString*)_date
      destinationID:(NSString*)_destinationID 
    destinationName:(NSString*)_destinationName 
      transactionID:(NSString*)_transactionID 
              notes:(NSString*)_notes 
           sourceID:(NSString*)_sourceID
         sourceName:(NSString*)_sourceName 
             status:(NSString*)_status 
               type:(NSString*)_type 
           userType:(NSString*)_userType
{
    if (self) 
    {
        amount = _amount;
        clearingDate = _clearingDate;
        date = _date;
        destinationID = _destinationID;
        destinationName= _destinationName;
        transactionID = _transactionID;
        notes = _notes;
        sourceID = _sourceID;
        sourceName = _sourceName;
        status = _status;
        type = _type;
        userType = _userType;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*) dictionary
{
    if (self)
    {
        amount = [dictionary objectForKey:AMOUNT_RESPONSE_NAME];
        clearingDate = [dictionary objectForKey:CLEARING_DATE_RESPONSE_NAME];
        date = [dictionary objectForKey:DATE_RESPONSE_NAME];
        destinationID = [dictionary objectForKey:DESTINATION_ID_RESPONSE_NAME];
        destinationName = [dictionary objectForKey:DESTINATION_NAME_RESPONSE_NAME];
        transactionID =  [dictionary objectForKey:ID_RESPONSE_NAME];
        notes = [dictionary objectForKey:NOTES_RESPONSE_NAME];
        sourceID = [dictionary objectForKey:SOURCE_ID_RESPONSE_NAME];
        sourceName =  [dictionary objectForKey:SOURCE_NAME_RESPONSE_NAME];
        status =  [dictionary objectForKey:STATUS_RESPONSE_NAME];
        type =  [dictionary objectForKey:TYPE_RESPONSE_NAME];
        userType = [dictionary objectForKey:USER_TYPE_RESPONSE_NAME];
    }
    return self;
}

-(BOOL)isEqualTo:(DwollaTransaction*)_transaction
{
    if (![destinationName isEqualToString:[_transaction destinationName]] || ![transactionID isEqualToString:[_transaction transactionID]] || ![userType isEqualToString:[_transaction userType]] || ![amount isEqualToString:[_transaction amount]] || ![status isEqualToString:[_transaction status]] || ![type isEqualToString:[_transaction type]] || ![destinationID isEqualToString:[_transaction destinationID]] || ![date isEqualToString:[_transaction date]])
    {
        return NO;
    }
    else 
    {
        return YES;
    }
}

@end
