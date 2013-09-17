//
//  DwollaAPI.h
//  DwollaSDK
//
//  Created by Nick Schulze on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  A class used to access the Dwolla API, must have an oauth 
//  token for most of the methods

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "DwollaUser.h"
#import "DwollaTransactions.h"
#import "DwollaFundingSources.h"
#import "DwollaTransactionStats.h"
#import "DwollaContact.h"
#import "OAuthTokenRepository.h"
#import "HttpRequestRepository.h"
#import "HttpRequestHelper.h"

static NSString *DWOLLA_API_BASEURL;

@interface DwollaAPI : NSObject
@property (retain) OAuthTokenRepository *oAuthTokenRepository;
@property (retain) HttpRequestRepository *httpRequestRepository;
@property (retain) HttpRequestHelper *httpRequestHelper;

+(id) sharedInstance;
+(void) setSharedInstance:(DwollaAPI*)_instance;

-(void) setBaseURL:(NSString*) url;
-(void)setAccessToken:(NSString*) token;
-(void)clearAccessToken;
-(void) setClientKey: (NSString*) token;
-(void) setClientSecret: (NSString*) token;

/**
 * sends money to the indicated user
 *
 * @param pin: the pin of the user sending the money (required)
 * @param destinationID: the id of the user receiving the money (required)
 * @param type: the type of account receiving the money, may be null
 * @param amount: the amount of money to be sent (required)
 * @param facilitatorAmount: the amount of money the facilitator gets from the transaction
 *                           may be null, can't exceed 25% of the amount
 * @param assumeCost: values accepted are either YES or NO, indicates if the user wants to 
 *                    assume the costs of the transaction, may be null
 * @param notes: notes to be delivered with the transaction, may be null
 * @param fundingSourceID: id of the funding source funds will be sent from, may be null
 *
 * @return string representing the transaction id
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(NSString*)sendMoneyWithPIN:(NSString*)pin
               destinationID:(NSString*)destinationID 
             destinationType:(NSString*)type
                      amount:(NSString*)amount
           facilitatorAmount:(NSString*)facAmount
                 assumeCosts:(NSString*)assumeCosts
                       notes:(NSString*)notes
             fundingSourceID:(NSString*)fundingID;

/**
 * requests money from the indicated user
 *
 * @param pin: the pin of the user requesting the money (required)
 * @param sourceID: the id of the user money is being requested from (required)
 * @param sourceType: the type of account money is being requested from, may be null
 * @param amount: the amount of money to be sent (required)
 * @param facilitatorAmount: the amount of money the facilitator gets from the transaction
 *                           may be null, can't exceed 25% of the amount
 * @param notes: notes to be delivered with the transaction, may be null
 *
 * @return string representing the request id
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(NSString*)requestMoneyWithPIN:(NSString*)pin
                       sourceID:(NSString*)sourceID
                     sourceType:(NSString*)type
                         amount:(NSString*)amount
              facilitatorAmount:(NSString*)facAmount
                          notes:(NSString*)notes;
   
/**
 * shows the balance of the current user
 *
 * @return float representation of the balance
 * @throws NSException if no access token is available, or request fails
 **/
-(float)getBalance;


/**
 * gets users contacts
 *
 * @param name: search term to search the contacts, may be null
 * @param types: the types of account to be returned, may be null
 * @param limit: the number of contacts to be returned
 *
 * @return a DwollaContacts object containing the results of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(NSMutableArray*)getContactsByName:(NSString*)name
                              types:(NSString*)types
                              limit:(NSString*)limit;

/**
 * gets nearby contacts
 *
 * @param latitude: the latitude to search from
 * @param longitude: the longitude to search from
 * @param limit: the number of contacts to be returned
 * @param range: the distance a contact may be from the latitude and longitude
 *
 * @return a DwollaContacts object containing the results of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(NSMutableArray*)getNearbyWithLatitude:(NSString*)lat
                            Longitude:(NSString*)lon
                                Limit:(NSString*)limit
                                Range:(NSString*)range;

/**
 * gets the funding sources of the current user
 *
 * @return a DwollaFundingSources object containing the results of the request
 * @throws NSException if no access token is available, or request fails
 **/
-(NSArray*)getFundingSources;

/**
 * gets the funding source details of the provided funding source
 *
 * @param sourceID: a string representation of the id of the funding source
 *
 * @return a DwollaFundingSource object containing the result of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(DwollaFundingSource*)getFundingSource:(NSString*)sourceID;


/**
 * gets the account information of the user
 *
 * @return a DwollaUser object containing the result of the request
 * @throws NSException if no access token is available, or request fails
 **/
-(DwollaUser*)getAccountInfo;


/**
 * gets the account information of the user with the given id
 *
 * @param accountID: a string representation of the id of the account
 *
 * @return a DwollaUser object containing the result of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(DwollaUser*)getBasicInfoWithAccountID:(NSString*)accountID;

/**
 * gets recent transactions
 *
 * @param date: the date to begin pulling transactions from 
 * @param limit: the number of transactions to be returned
 * @param skip: the number of transactions to skip
 *
 * @return a DwollaTransactions object contiaining the results of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(NSArray*)getTransactionsSince:(NSString*)date
                                  withType:(NSString*)type
                                 withLimit:(NSString*)limit
                                  withSkip:(NSString*)skip;

/**
 * gets the transaction details of the provided transactionID
 *
 * @param transactionID: a string representation of the id of the transaction
 *
 * @return a DwollaTransaction object containing the result of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(DwollaTransaction*)getTransaction:(NSString*)transactionID;

/**
 * gets the transaction stats for the user
 *
 * @param start: the date to begin pulling the stats from
 * @param end: the date to stop pulling the stats from
 *
 * @return a DwollaTransactionStats object containing the results of the request
 * @throws NSException if parameters are invalid, no access token is available, or request fails
 **/
-(DwollaTransactionStats*)getTransactionStatsWithStart:(NSString*)start
                                               withEnd:(NSString*)end
                                             withTypes:(NSString*)types;
@end
