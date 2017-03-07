//
//  WeatherBusiness.m
//  WeatherOrNot
//
//  Created by Sasha on 06/03/17.
//  Copyright © 2017 ShwtMhjn. All rights reserved.
//

#import "WeatherBusiness.h"
#import "WebConnectionHandler.h"
#import "Utilities.h"

#define REQUEST_TYPE_POST @"POST"
#define REQUEST_TYPE_GET @"GET"
#define CONNECTION_TIME_OUT 30
#define APPLICATION_CONTENT_TYPE_URLENCODED @"application/x-www-form-urlencoded"
#define KEY_CONTENT_TYPE  @"Content-Type"


static NSString *const forecastApiUrl   = @"http://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&APPID=3f0df6df7720bb69eacea6fc011d57a5";

//static NSString *const forecastApiBody   = @"lat={lat}&lon={lon}&APPID=3f0df6df7720bb69eacea6fc011d57a5";
static NSString *const kNetworkErrorDomain   = @"Network Unreachable";
static int const kNetworkErrorCode = 999;

@implementation WeatherBusiness

- (void) callWeatherApiForLocation:(CLLocation *)location onSuccess:(WeatherFetchSuccess)onSuccessBlock onFailure:(WeatherFetchFailure)onFailureBlock
{
    __block NSError *error = nil;
    if(![Utilities isNetworkReachable]){
        error = [[NSError alloc] initWithDomain:kNetworkErrorDomain code:kNetworkErrorCode userInfo:nil];
        onFailureBlock(error);
            return;
    }

    NSString *urlString = [forecastApiUrl stringByReplacingOccurrencesOfString:@"{lat}" withString:[NSString stringWithFormat:@"%f", location.coordinate.latitude]]; //Add the Latitude parameter
    urlString = [urlString stringByReplacingOccurrencesOfString:@"{lon}" withString:[NSString stringWithFormat:@"%f", location.coordinate.longitude]];  //Add the Longitude parameter
    
//    NSString *urlString = [NSString stringWithFormat:@"%@", forecastApiUrl];
    
    NSURLRequest *request = [self createRequestWithURL:urlString withBody:nil andHeader:[[NSDictionary alloc]initWithObjectsAndKeys:APPLICATION_CONTENT_TYPE_URLENCODED,KEY_CONTENT_TYPE, nil] method:REQUEST_TYPE_GET];
    
    WebConnectionHandler *webConnectionHandler = [[WebConnectionHandler alloc] init];
    [webConnectionHandler executeRequest:request onSuccess:^(NSURLResponse *response, NSData *data) {
        NSDictionary *responseDictionary = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];

        onSuccessBlock(responseDictionary);

    } failure:^(NSURLResponse *response, NSData *data, NSError *error) {
        onFailureBlock(error);
    }];
}


//-----------------------------------------------------------------------------------------------------------------------------
/*!
 @method        createRequestWithURL: withBody: andHeader:
 @param         url body, header
 @return        NSMutableURLRequest
 @brief         To create a mutable request with the url, body, header and method
 */
//-----------------------------------------------------------------------------------------------------------------------------
- (NSMutableURLRequest *) createRequestWithURL:(NSString *) url withBody:(NSString *) body andHeader:(NSDictionary *) header method:(NSString*)requestMethod {
    NSString *urlString = url; // there is no need to add the host domain because it already exists
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:CONNECTION_TIME_OUT];
    
    [request setHTTPMethod:requestMethod];
    
    if ([requestMethod isEqualToString:REQUEST_TYPE_POST]) {
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [request setAllHTTPHeaderFields:header];
    return request;
}

@end
