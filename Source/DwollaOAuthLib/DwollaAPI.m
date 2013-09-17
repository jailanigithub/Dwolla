//
//  DwollaAPI.m
//  DwollaSDK
//
//  Created by Nick Schulze on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaAPI.h"
#import "Constants.m"


@implementation DwollaAPI

@synthesize oAuthTokenRepository, httpRequestRepository, httpRequestHelper;

static DwollaAPI* sharedInstance;

-(id) init {
    self = [super self];
    if(self){
        self.oAuthTokenRepository = [[OAuthTokenRepository alloc] init];
        self.httpRequestRepository = [[HttpRequestRepository alloc] init];
        self.httpRequestHelper = [[HttpRequestHelper alloc] init];
    }
    return self;
}

+(id) sharedInstance {
    if(!sharedInstance){
        sharedInstance = [[DwollaAPI alloc] init];
    }
    return sharedInstance;
}

+(void) setSharedInstance:(DwollaAPI *)_instance {
    sharedInstance = _instance;
}

-(void) setBaseURL:(NSString*) url {
    DWOLLA_API_BASEURL = url;
}

-(NSString*)sendMoneyWithPIN:(NSString*)pin
               destinationID:(NSString*)destinationID
             destinationType:(NSString*)type
                      amount:(NSString*)amount
           facilitatorAmount:(NSString*)facAmount
                 assumeCosts:(NSString*)assumeCosts
                       notes:(NSString*)notes
             fundingSourceID:(NSString*)fundingID
{
    //Setting Up URL
    NSString *token = [self.oAuthTokenRepository getAccessToken];
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@?oauth_token=%@", SEND_URL, token];
    
    //Checking Parameters
    [self isParameterNullOrEmpty: pin andThrowErrorWithName: PIN_ERROR_NAME];
    [self isParameterNullOrEmpty: destinationID andThrowErrorWithName: DESTINATION_ID_ERROR_NAME];
    [self isParameterNullOrEmpty: amount andThrowErrorWithName: AMOUNT_ERROR_NAME];
    
    //Creating Parameters Dictionary
    NSMutableDictionary* parameterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         pin, PIN_PARAMETER_NAME,
                                         destinationID, DESTINATION_ID_PARAMETER_NAME,
                                         amount, AMOUNT_PARAMETER_NAME, nil];
    
    if (type != nil && ![type isEqualToString:@""]) [parameterDictionary setObject:type forKey:DESTINATION_TYPE_PARAMETER_NAME];
    if (facAmount != nil && ![facAmount isEqualToString:@""]) [parameterDictionary setObject:facAmount forKey:FACILITATOR_AMOUNT_PARAMETER_NAME];
    if (assumeCosts != nil && ![assumeCosts isEqualToString:@""]) [parameterDictionary setObject:assumeCosts forKey:ASSUME_COSTS_PARAMETER_NAME];
    if (notes != nil && ![notes isEqualToString:@""]) [parameterDictionary setObject:notes forKey:NOTES_PARAMETER_NAME];
    if (fundingID != nil && ![fundingID isEqualToString:@""]) [parameterDictionary setObject:fundingID forKey:FUNDING_SOURCE_PARAMETER_NAME];
    
    //Making the POST Request && Verifying
    NSDictionary* dictionary = [httpRequestRepository postRequest: url withParameterDictionary:parameterDictionary];
    
    //Parsing and responding
    return [[NSString alloc] initWithFormat:@"%@",[dictionary valueForKey:RESPONSE_RESULT_PARAMETER]];
}

-(NSString*)requestMoneyWithPIN:(NSString*)pin  
                 sourceID:(NSString*)sourceID 
               sourceType:(NSString*)type
                   amount:(NSString*)amount
        facilitatorAmount:(NSString*)facAmount
                    notes:(NSString*)notes
{
    NSString* token = [self.oAuthTokenRepository getAccessToken];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@?oauth_token=%@", REQUEST_URL, token];
    
    //Checking Parameters
    [self isParameterNullOrEmpty: pin andThrowErrorWithName: PIN_ERROR_NAME];
    [self isParameterNullOrEmpty: sourceID andThrowErrorWithName: SOURCE_ID_ERROR_NAME];
    [self isParameterNullOrEmpty: amount andThrowErrorWithName: AMOUNT_ERROR_NAME];
    
    //Creating Parameters Dictionary
    NSMutableDictionary* parameterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                pin, PIN_PARAMETER_NAME,
                                                sourceID, SOURCE_ID_PARAMETER_NAME,
                                                amount, AMOUNT_PARAMETER_NAME, nil];
    
    if (type != nil && ![type isEqualToString:@""]) [parameterDictionary setObject:type forKey:SOURCE_TYPE_PARAMETER_NAME];
    if (facAmount != nil && ![facAmount isEqualToString:@""]) [parameterDictionary setObject:facAmount forKey:FACILITATOR_AMOUNT_PARAMETER_NAME];
    if (notes != nil && ![notes isEqualToString:@""]) [parameterDictionary setObject:notes forKey:NOTES_PARAMETER_NAME];
    
    //Making the POST Request && Verifying
    NSDictionary* dictionary = [httpRequestRepository postRequest: url withParameterDictionary: parameterDictionary];
    
    //Parsing and responding
    return [[NSString alloc] initWithFormat:@"%@",[dictionary valueForKey:RESPONSE_RESULT_PARAMETER]];
}

-(float)getBalance
{
    NSString* token = [self.oAuthTokenRepository getAccessToken];

    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@?oauth_token=%@", BALANCE_URL, token];

    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url];
    
    BOOL success = [[dictionary valueForKey:@"Success"] boolValue];
    if (!success){
        NSString *message = [dictionary valueForKey:@"Message"];
        if(!message){
            message = @"Unknown error occurred";
        }
        NSLog(@"==== Error Message ===== %@ \n\n",message);
        return 0.0;
    }
    return [[dictionary objectForKey:RESPONSE_RESULT_PARAMETER] floatValue];
}

-(NSMutableArray*)getContactsByName:(NSString*)name
                              types:(NSString*)types
                              limit:(NSString*)limit
{
    //Creating Parameters Dictionary
    NSMutableDictionary* parameterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                [self.oAuthTokenRepository getAccessToken], OAUTH_TOKEN_PARAMETER_NAME, nil];
    
    if (name != nil && ![name isEqualToString:@""]) [parameterDictionary setObject:name forKey:NAME_PARAMETER_NAME];
    if (types != nil && ![types isEqualToString:@""]) [parameterDictionary setObject:types forKey:TYPES_PARAMETER_NAME];
    if (limit != nil && ![limit isEqualToString:@""]) [parameterDictionary setObject:limit forKey:LIMIT_PARAMETER_NAME];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingString:CONTACTS_URL];
    
    //Make GET Request and Verify
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url withQueryParameterDictionary:parameterDictionary];
    
    NSArray* data =[dictionary valueForKey:RESPONSE_RESULT_PARAMETER];
    
    NSMutableArray* contacts = [[NSMutableArray alloc] initWithCapacity:[data count]];
    
    //Setup All of the Contacts
    for (int i = 0; i < [data count]; i++)
        [contacts addObject:[[DwollaContact alloc] initWithDictionary:[data objectAtIndex:i]]];
    
    return contacts;
}

-(NSMutableArray*)getNearbyWithLatitude:(NSString*)lat
                            Longitude:(NSString*)lon
                                Limit:(NSString*)limit
                                Range:(NSString*)range
{
    //Creating Parameters Dictionary
    NSMutableDictionary* parameterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                [self.oAuthTokenRepository getClientKey], CLIENT_ID_PARAMETER_NAME,
                                                [self.oAuthTokenRepository getClientSecret], CLIENT_SECRET_PARAMETER_NAME, nil];
    
    if (lat != nil && ![lat isEqualToString:@""]) [parameterDictionary setObject:lat forKey:LATITUDE_PARAMETER_NAME];
    if (lon != nil && ![lon isEqualToString:@""]) [parameterDictionary setObject:lon forKey:LONGITUDE_PARAMETER_NAME];
    if (limit != nil && ![limit isEqualToString:@""]) [parameterDictionary setObject:limit forKey:LIMIT_PARAMETER_NAME];
    if (range != nil && ![range isEqualToString:@""]) [parameterDictionary setObject:range forKey:RANGE_PARAMETER_NAME];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingString:NEARBY_URL];
    
    //Make GET Request and Verify
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url withQueryParameterDictionary:parameterDictionary];
    
    NSArray* data =[dictionary valueForKey:RESPONSE_RESULT_PARAMETER];
    
    NSMutableArray* contacts = [[NSMutableArray alloc] initWithCapacity:[data count]];
    
    //Setup All of the Contacts
    for (int i = 0; i < [data count]; i++)
        [contacts addObject:[[DwollaContact alloc] initWithDictionary:[data objectAtIndex:i]]];
    
    return contacts;
}

-(NSArray*)getFundingSources
{
    
    NSString* token = [self.oAuthTokenRepository getAccessToken];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@?oauth_token=%@", FUNDING_SOURCES_URL, token];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url];

    NSArray* data =[dictionary valueForKey:RESPONSE_RESULT_PARAMETER];
    
    NSMutableArray* sources = [[NSMutableArray alloc] initWithCapacity:[data count]];
    for (int i = 0; i < [data count]; i++)
    {
        [sources addObject:[[DwollaFundingSource alloc] initWithDictionary:[data objectAtIndex:i]]];
    }
    
    return sources;
}

-(DwollaFundingSource*)getFundingSource:(NSString*)sourceID
{

    NSString* token = [self.oAuthTokenRepository getAccessToken];
    
    [self isParameterNullOrEmpty: sourceID andThrowErrorWithName: SOURCE_ID_ERROR_NAME];
      
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@/%@?oauth_token=%@", FUNDING_SOURCES_URL, [self.httpRequestHelper encodeString:sourceID], token];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url];
    
    return [[DwollaFundingSource alloc] initWithDictionary:[dictionary valueForKey:RESPONSE_RESULT_PARAMETER]];
}

-(DwollaUser*)getAccountInfo
{
    NSString* token = [self.oAuthTokenRepository getAccessToken];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@?oauth_token=%@", USERS_URL, token];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url];
    BOOL success = [[dictionary valueForKey:@"Success"] boolValue];
    if (!success){
        NSString *message = [dictionary valueForKey:@"Message"];
        if(!message){
            message = @"Unknown error occurred";
        }
        NSLog(@"==== Error Message ===== %@ \n\n",message);
        return nil;
    }
    NSDictionary* response = [dictionary valueForKey:RESPONSE_RESULT_PARAMETER];

    return [[[DwollaUser alloc] initWithDictionary:response] autorelease];
}

-(DwollaUser*)getBasicInfoWithAccountID:(NSString*)accountID
{
    NSString* key = [self.oAuthTokenRepository getClientKey];
    NSString* secret = [self.oAuthTokenRepository getClientSecret];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@/%@?client_id=%@&client_secret=%@", USERS_URL, accountID, key, secret];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url];

    NSDictionary* values = [dictionary valueForKey:RESPONSE_RESULT_PARAMETER];
    
    return [[DwollaUser alloc] initWithDictionary:values];
}

-(NSArray*)getTransactionsSince:(NSString*)date
                                  withType:(NSString*)type
                                 withLimit:(NSString*)limit
                                  withSkip:(NSString*)skip;
{
    NSMutableDictionary* parameterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                [self.oAuthTokenRepository getAccessToken], OAUTH_TOKEN_PARAMETER_NAME, nil];
    
    if (date != nil && ![date isEqualToString:@""]) [parameterDictionary setObject:date forKey:LATITUDE_PARAMETER_NAME];
    if (limit != nil && ![limit isEqualToString:@""]) [parameterDictionary setObject:limit forKey:LIMIT_PARAMETER_NAME];
    if (skip != nil && ![skip isEqualToString:@""]) [parameterDictionary setObject:skip forKey:SKIP_PARAMETER_NAME];
    if (type != nil && ![type isEqualToString:@""]) [parameterDictionary setObject:type forKey:TYPES_PARAMETER_NAME];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@", TRANSACTIONS_URL];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url withQueryParameterDictionary: parameterDictionary];
    
    NSArray* data =[dictionary valueForKey:RESPONSE_RESULT_PARAMETER];
    
    NSMutableArray* transactions = [[NSMutableArray alloc] initWithCapacity:[data count]];
    for (int i = 0; i < [data count]; i++)
        [transactions addObject:[[DwollaTransaction alloc] initWithDictionary:[data objectAtIndex:i]]];
    
   return transactions;
}

-(DwollaTransaction*)getTransaction:(NSString*)transactionID
{
    NSString* token = [self.oAuthTokenRepository getAccessToken];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@/%@?oauth_token=%@", TRANSACTIONS_URL, transactionID, token];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url];

    return [[DwollaTransaction alloc] initWithDictionary:[dictionary valueForKey:RESPONSE_RESULT_PARAMETER]];
}

-(DwollaTransactionStats*)getTransactionStatsWithStart:(NSString*)start
                                               withEnd:(NSString*)end
                                             withTypes:(NSString*)types
{
    NSMutableDictionary* parameterDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                [self.oAuthTokenRepository getAccessToken], OAUTH_TOKEN_PARAMETER_NAME, nil];
    
    if (start != nil && ![start isEqualToString:@""]) [parameterDictionary setObject:start forKey:START_DATE_PARAMETER_NAME];
    if (end != nil && ![end isEqualToString:@""]) [parameterDictionary setObject:end forKey:END_DATE_PARAMETER_NAME];
    if (types != nil && ![types isEqualToString:@""]) [parameterDictionary setObject:types forKey:TYPES_PARAMETER_NAME];
    
    NSString* url = [DWOLLA_API_BASEURL stringByAppendingFormat:@"%@", TRANSACTIONS_STATS_URL];
    
    NSDictionary* dictionary = [self.httpRequestRepository getRequest:url withQueryParameterDictionary: parameterDictionary];
 
    return [[DwollaTransactionStats alloc] initWithDictionary: [dictionary valueForKey:RESPONSE_RESULT_PARAMETER]];
}

-(void)setAccessToken:(NSString*) token{
    [self.oAuthTokenRepository setAccessToken:token];
}
-(void)clearAccessToken{
    [self.oAuthTokenRepository clearAccessToken];
}
-(void) setClientKey: (NSString*) token{
    [self.oAuthTokenRepository setClientKey:token];
}
-(void) setClientSecret: (NSString*) token{
    [self.oAuthTokenRepository setClientSecret:token];
}

-(BOOL) isParameterNullOrEmpty: (NSString*) value
andThrowErrorWithName: (NSString*) name
{
    if(value == nil || [value isEqualToString:@""])
    {
        @throw [NSException exceptionWithName:@"INVALID_PARAMETER_EXCEPTION"
                                       reason:[[NSString alloc] initWithFormat:@"%@ is required", name] userInfo:nil];
        return false;
    }
    return true;
}

@end
