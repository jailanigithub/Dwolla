//
//  NSURLConnectionRepository.h
//  DwollaOAuth
//
//  Created by James Armstead on 12/19/12.
//
//

#import <Foundation/Foundation.h>
#import "HttpRequestHelper.h"

@interface NSURLConnectionRepository : NSObject
@property (retain) HttpRequestHelper *httpRequestHelper;

- (NSDictionary *)sendSynchronousRequest:(NSURLRequest *)request;

@end
