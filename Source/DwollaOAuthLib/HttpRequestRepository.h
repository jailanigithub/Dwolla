//
//  RequestRepository.h
//  DwollaOAuth
//
//  Created by James Armstead on 12/18/12.
//
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "HttpRequestHelper.h"
#import "NSURLConnectionRepository.h"

@interface HttpRequestRepository : NSObject
@property (retain) HttpRequestHelper *httpRequestHelper;
@property (retain) NSURLConnectionRepository *nsURLConnectionRepository;

-(NSDictionary*)postRequest: (NSString*) url
    withParameterDictionary: (NSDictionary*) parameterDictionary;

-(NSDictionary*)getRequest: (NSString*) url;

-(NSDictionary*)getRequest: (NSString*) url
withQueryParameterDictionary: (NSDictionary*) dictionary;

@end
