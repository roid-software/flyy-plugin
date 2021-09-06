#import "Flyyplugin.h"

@implementation FlyyPlugin

- (void)setAppPackage: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* packageName = [command.arguments objectAtIndex:0];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (packageName != nil && packageName.length > 0 ) {
        [flyyInstance setPackageWithPackageName:packageName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)initSDK: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* partnerToken = [command.arguments objectAtIndex:0];
    NSString* environment = [command.arguments objectAtIndex:1];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (partnerToken != nil && partnerToken.length > 0 && environment != nil && environment.length > 0) {
        if ([environment  isEqual: @"stage"]) {
            [flyyInstance initSDKWithPartnerToken:partnerToken environment: [flyyInstance production]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        } else if ([environment  isEqual: @"production"]) {
            [flyyInstance initSDKWithPartnerToken:partnerToken environment: [flyyInstance production]];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected enviroment variable as either 'stage' or 'production'."];
            
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUser: (CDVInvokedUrlCommand *) command {
    __block CDVPluginResult* pluginResult = nil;
    NSString* extUid = [command.arguments objectAtIndex:0];
    NSString* segmentId = [command.arguments objectAtIndex:1];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (extUid != nil && extUid.length > 0) {
        [flyyInstance setUserWithExternalUserId:extUid segmentId:segmentId onComplete: ^(BOOL success) {
               if(success) {
                   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
               } else {
                   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"false"];
               }
           }];
        
//        [flyyInstance setUserWithExternalUserId:extUid segmentId:segmentId];
        
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setNewUser: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* extUid = [command.arguments objectAtIndex:0];
    NSString* segmentId = [command.arguments objectAtIndex:1];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (extUid != nil && extUid.length > 0) {
        [flyyInstance setNewUserWithExternalUserId:extUid segmentId:segmentId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected two non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setUsername: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* userName = [command.arguments objectAtIndex:0];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (userName != nil && userName.length > 0) {
        [flyyInstance setUserNameWithUserName:userName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)openOfferActivity: (CDVInvokedUrlCommand *) command {
    CDVPluginResult* pluginResult = nil;
    NSString* segmentId = [command.arguments objectAtIndex:0];
    
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    if (segmentId != nil && segmentId.length > 0) {
        [flyyInstance setSegmentIdWithSegementId:segmentId];
        [self naviagteToPage:@"Loading Offers..." :@"https://web-sdk.theflyy.com/" :segmentId];
//        [flyyInstance openOffersPageWithNavigationController:self.viewController.navigationController segmentId:segmentId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Expected one non-empty string argument."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) naviagteToPage :(NSString *)pageTitle :(NSString *)pageurl :(NSString *)segmentId {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            UINavigationController *navController = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            WebViewController *webViewController = [[WebViewController alloc] init];
            webViewController.pageLoadingTitle = pageTitle;
            webViewController.pageUrl = pageurl;
            webViewController.segmentId = segmentId;
            navController.navigationBarHidden = YES;
            [navController pushViewController:webViewController animated:YES];
        });
    });
}

@end

