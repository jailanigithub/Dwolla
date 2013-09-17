//
//  DwollaOAuth2Client.m
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DwollaOAuth2Client.h"

@implementation DwollaOAuth2Client

@synthesize oAuthTokenRepository, httpRequestHelper;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        oAuthTokenRepository = [[OAuthTokenRepository alloc] init];
        httpRequestHelper = [[HttpRequestHelper alloc] init];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame 
                key:(NSString*)_key
             secret:(NSString*)_secret
           redirect:(NSString*)_redirect
           response:(NSString*)_response
             scopes:(NSArray*)_scopes
               view:(UIView*)_view
           reciever:(id<IDwollaMessages>)_receiver
{
    self = [self initWithFrame:frame];
    if (self)
    {
        key = [self.httpRequestHelper encodeString:_key];
        secret = [self.httpRequestHelper encodeString:_secret];
        [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"key"];
        [[NSUserDefaults standardUserDefaults] setObject:secret forKey:@"secret"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        redirect = _redirect;
        response = _response;
        scopes = _scopes;
        superView = _view;
        receiver = _receiver;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.scalesPageToFit = YES;
        self.dataDetectorTypes = UIDataDetectorTypeNone;
        self.delegate = self;
        [superView addSubview:self];
    }
    return self;
}

-(void) login
{
    NSURLRequest* url = [self generateURLWithKey:key
                                      redirect:redirect
                                      response:response
                                        scopes:scopes];
    [self loadRequest:url];
}

-(void)logout
{
    [oAuthTokenRepository clearAccessToken];
}

-(BOOL)isAuthorized
{
    return [oAuthTokenRepository hasAccessToken];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationType
{
    NSMutableURLRequest *request = (NSMutableURLRequest *)req; 
    
    NSArray *urlItems = [[request.URL query] componentsSeparatedByString:@"&"];
    NSMutableArray *urlValues = [[NSMutableArray alloc] initWithCapacity:[urlItems count]];
    
    for (int i = 0; i<[urlItems count]; i++) 
    {
        NSArray *keysValues = [[urlItems objectAtIndex:i] componentsSeparatedByString:@"="];
        [urlValues insertObject:keysValues atIndex:i];
    }
    
    if([urlValues count]>0 && [self hasCode:urlValues]) 
    {
        [self requestAccessToken:[[urlValues objectAtIndex:0]objectAtIndex:1]];
        return NO;
    }
    return YES;
}

-(BOOL)hasCode:(NSMutableArray*)urlValues
{
    
    if ([[[urlValues objectAtIndex:0] objectAtIndex:0] isEqualToString:@"error"]) 
    {
        [receiver failedLogin:urlValues];
        return NO;
    }
    else if ([[[urlValues objectAtIndex:0] objectAtIndex:0] isEqualToString:@"code"]) 
    {
        return YES;
    }
    return NO;
}

-(void)requestAccessToken:(NSString*)code
{
    
    NSString* url = [NSString stringWithFormat: @"https://www.dwolla.com/oauth/v2/token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=https://www.dwolla.com&code=%@", key, secret, code];
    
    
    NSURL* fullURL = [[NSURL alloc] initWithString:url];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fullURL 
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"POST"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString *dataString = [[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding]; 
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSDictionary *dictionary = [parser objectWithString:dataString];
    
    NSString* token =[dictionary objectForKey:@"access_token"];
    
    token = [self.httpRequestHelper encodeString:token];
    
    
    NSLog(@"======= OAuth Generated Token %@ ====== \n\n", token);
    [oAuthTokenRepository setAccessToken:token];
    
    [receiver successfulLogin];
    [self removeFromSuperview];
}




-(NSURLRequest*)generateURLWithKey:(NSString*)keyParam
                          redirect:(NSString*)redirectParam
                          response:(NSString*)responseParam
                            scopes:(NSArray*)scopesParam
{
    if (keyParam == nil || [keyParam isEqualToString:@""])
    {
        @throw [NSException exceptionWithName:@"INVALID_APPLICATION_CREDENTIALS_EXCEPTION"
                                       reason:@"your application key is invalid"
                                     userInfo:nil];
    }
    if(redirectParam == nil || [redirectParam isEqualToString:@""] || responseParam == nil ||
       [responseParam isEqualToString:@""] || scopesParam == nil || [scopesParam count] == 0)
    {
        @throw [NSException exceptionWithName:@"INVALID_PARAMETER_EXCEPTION"
                                       reason:@"either redirect, response, or scopes is nil or empty" userInfo:nil];
    }
    NSString* url = [NSString stringWithFormat:@"https://www.dwolla.com/oauth/v2/authenticate?client_id=%@&response_type=%@&redirect_uri=%@&scope=", keyParam, responseParam, redirectParam];
    
    for (int i = 0; i < [scopesParam count]; i++)
    {
        url = [url stringByAppendingString:[scopesParam objectAtIndex:i]];
        if([scopesParam count] > 0 && i < [scopesParam count]-1)
        {
            url = [url stringByAppendingString:@"%7C"];
        }
    }
    
    NSURL* fullURL = [[NSURL alloc] initWithString:url];
    
    NSURLRequest* returnURL = [[NSURLRequest alloc] initWithURL:fullURL cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:100];
    
    return returnURL;
}


@end
