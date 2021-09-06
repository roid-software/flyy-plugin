#import <Cordova/CDV.h>
#import <FlyyFramework/FlyyFramework.h>
#import "WebViewController.h"

@interface FlyyPlugin : CDVPlugin {
    
}

- (void)setAppPackage:(CDVInvokedUrlCommand *)command;
- (void)initSdk:(CDVInvokedUrlCommand *)command;
- (void)setUser:(CDVInvokedUrlCommand *)command;
- (void)setNewUser:(CDVInvokedUrlCommand *)command;
- (void)setUsername:(CDVInvokedUrlCommand *)command;
- (void)startOfferActivity:(CDVInvokedUrlCommand *)command;



@end
