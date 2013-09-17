//
//  DwollaOAuth2Client.h
//  DwollaOAuth
//
//  Created by Nick Schulze on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  A class used to obtain an access token for accessing the
//  Dwolla API

#import <UIKit/UIKit.h>
#import "IDwollaMessages.h"
#import "SBJson.h"
#import "NSString+URLEncoding.h"
#import "OAuthTokenRepository.h"
#import "HttpRequestHelper.h"

@interface DwollaOAuth2Client : UIWebView <UIWebViewDelegate>
{
    NSString* redirect;
    NSString* key;
    NSString* secret;
    NSString* response;
    NSArray* scopes;
    UIView* superView;
    id<IDwollaMessages> receiver;
}
@property (retain) OAuthTokenRepository *oAuthTokenRepository;
@property (retain) HttpRequestHelper *httpRequestHelper;

/** 
 * initializes an instance of the DwollaO2AuthClient allowing the user to 
 * login and logout of their Dwolla account
 *
 * @param frame: frame the webview will be initialized in
 * @param key: the application key provided by the Dwolla website
 * @param secret: the application secret provided by the Dwolla website
 * @param redirect: the website the user will be redirected to 
 * @param scopes: scopes the developer wants to use in the application
 * @param view: view that will contain the instance of webView
 * @param receiver: class that will recieve the successfulLogin/unsuccessfulLogin notification
 *
 * @return an instance of DwollaOAuth2Client
 **/
-(id)initWithFrame:(CGRect)frame 
               key:(NSString*)key
            secret:(NSString*)secret
          redirect:(NSString*)redirect
          response:(NSString*)response
            scopes:(NSArray*)scopes
              view:(UIView*)view
          reciever:(id<IDwollaMessages>)receiver;

/** 
 * checks to see if a valid access token is available
 *
 * @return YES if a valid access token is present, false otherwise
 **/
-(BOOL)isAuthorized;

/** 
 * calls a webview and allows the user to login to 
 * Dwolla from within the application 
 **/
-(void) login;

/** 
 * clears the user's access token, logging them out
 * and disabling the Dwolla integration 
 **/
-(void) logout;

@end
