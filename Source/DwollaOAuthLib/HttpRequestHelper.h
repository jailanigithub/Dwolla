//
//  HttpRequestHelper.h
//  DwollaOAuth
//
//  Created by James Armstead on 12/19/12.
//
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface HttpRequestHelper : NSObject

-(NSDictionary*)generateDictionaryWithData:(NSData*)data;
-(NSDictionary*)generateDictionaryWithString:(NSString*)dataString;

-(NSString*) getStringFromDictionary:(NSDictionary*)dictionary
                              ForKey:(NSString*) key;

-(NSData*) getJSONDataFromNsDictionary:(NSDictionary*)dictionary;
-(NSDictionary*) checkRequestForSuccessAndReturn:(NSDictionary*) dictionary;

-(NSString*) getQueryParametersFroNSDictionary:(NSDictionary*)dictionary;
-(NSString*) encodeString: (NSString*) string;
@end
