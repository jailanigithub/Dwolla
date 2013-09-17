//
//  RequestRepository.m
//  DwollaOAuth
//
//  Created by James Armstead on 12/18/12.
//
//

#import "HttpRequestRepository.h"

@implementation HttpRequestRepository

@synthesize httpRequestHelper, nsURLConnectionRepository;

-(id) init {
    self = [super self];
    if(self){
        self.httpRequestHelper = [[HttpRequestHelper alloc] init];
        self.nsURLConnectionRepository = [[NSURLConnectionRepository alloc] init];
    }
    return self;
}

-(NSDictionary*)postRequest: (NSString*) url
    withParameterDictionary: (NSDictionary*) parameterDictionary
{
    NSData* body = [httpRequestHelper getJSONDataFromNsDictionary:parameterDictionary];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod: @"POST"];
    
    [request setHTTPBody:body];
    
    NSLog(@"======= Post Methods Request url ======= %@ \n\n ======= Post Methods Request Body ======= %@", url, body);
    
    NSDictionary *resultDictionary = [self.nsURLConnectionRepository sendSynchronousRequest:request];
    
    return [self.httpRequestHelper checkRequestForSuccessAndReturn: resultDictionary];
}

-(NSDictionary*)getRequest: (NSString*) url
{
    NSLog(@"======= Get Methods Request url ======= %@ \n\n", url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];

    [request setHTTPMethod: @"GET"];
    
    NSDictionary *result = [self.nsURLConnectionRepository sendSynchronousRequest:request];
    
    return result;
}

-(NSDictionary*)getRequest: (NSString*) url
withQueryParameterDictionary: (NSDictionary*) dictionary
{
    return [self getRequest: [url stringByAppendingFormat:@"?%@", [self.httpRequestHelper getQueryParametersFroNSDictionary:dictionary]]];
}

@end
