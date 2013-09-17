//
//  NSURLConnectionRepository.m
//  DwollaOAuth
//
//  Created by James Armstead on 12/19/12.
//
//

#import "NSURLConnectionRepository.h"

@implementation NSURLConnectionRepository

@synthesize httpRequestHelper;

-(id) init {
    self = [super self];
    if(self){
        self.httpRequestHelper = [[HttpRequestHelper alloc] init];
    }
    return self;
}

- (NSDictionary *)sendSynchronousRequest:(NSURLRequest *)request
{
    NSError *requestError;
    NSURLResponse *urlResponse = nil;

    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    return [self.httpRequestHelper generateDictionaryWithData:result];
}

@end
