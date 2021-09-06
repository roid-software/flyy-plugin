#import <Cordova/CDV.h>
#import <FlyyFramework/FlyyFramework.h>
#import "WebViewController.h"

@interface FlyyPlugin : CDVPlugin

@property NSString *callbackId;

- (void)setAppPackage:(CDVInvokedUrlCommand *)command;
- (void)initSDK:(CDVInvokedUrlCommand *)command;
- (void)setUser:(CDVInvokedUrlCommand *)command;
- (void)setNewUser:(CDVInvokedUrlCommand *)command;
- (void)setUsername:(CDVInvokedUrlCommand *)command;
- (void)openOfferActivity:(CDVInvokedUrlCommand *)command;

@end
