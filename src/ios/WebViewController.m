//
//  WebViewController.m
//  Flyy
//
//  Created by Pooja Deshpande on 08/01/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "FlyyFramework/FlyyFramework.h"

@interface WebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (strong,nonatomic) WKWebView *wkWebView;
@property (strong,nonatomic) UILabel *loadingOffer;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TODO VISHAL
    //self.view.backgroundColor = [self colorFromHexString: self.themeColor];
    //    self.title = @"Offer screen";
     self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.barTintColor = [self colorFromHexString: self.themeColor];
//    self.navigationItem.hidesBackButton = YES;

    // Add and load URL in Webview
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.wkWebView.navigationDelegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    NSURL *nsurl=[NSURL URLWithString:self.pageUrl];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.wkWebView loadRequest:nsrequest];
    
    NSString *scriptSource = [NSString stringWithFormat:@"%@ %@ %s %@ %@",@"var meta = document.createElement('meta');",@"meta.name = 'viewport';","meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';",@"var head = document.getElementsByTagName('head')[0];",@"head.appendChild(meta);"];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:scriptSource
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                   forMainFrameOnly:YES];
    [self.wkWebView.configuration.userContentController addUserScript:userScript];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"handleMessage"];
    [self.view addSubview:self.wkWebView];
    
    // Add label to show message
    
    self.loadingOffer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.loadingOffer.text = self.pageLoadingTitle;
    self.loadingOffer.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    self.loadingOffer.backgroundColor = [UIColor clearColor];
    self.loadingOffer.textColor = [UIColor blackColor];
    self.loadingOffer.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.loadingOffer];
    
}

-(void) viewDidLayoutSubviews
{
    self.loadingOffer.center = self.view.center;
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.loadingOffer.text = @"";
    self.loadingOffer.hidden = YES;
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self sendDataToJS];
    self.loadingOffer.text = @"";
    self.loadingOffer.hidden = YES;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"userContentController:didReceiveScriptMessage: message=%@", message);
    if ([message.name isEqualToString:@"handleMessage"])
    {
        if ([message.body isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *body = message.body;
            NSString *param = body[@"action"];
            if ([param isEqualToString:@"go-back"])
            {
                if(self.wkWebView.canGoBack)
                {
                    [self.wkWebView goBack];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } else if ([param isEqualToString:@"quiz-list"])
            {
                Flyy *flyyInstance = [[Flyy alloc] init];
                [flyyInstance openFlyyQuizListViewControllerWithNavigationController:self.navigationController];
            } else if ([param isEqualToString:@"quiz-details"])
            {
                Flyy *flyyInstance = [[Flyy alloc] init];
                [flyyInstance openFlyyQuizViewControllerWithNavigationController:self.navigationController];
            }
            else if ([param isEqualToString:@"share"])
            {
                NSString *shareUrl = body[@"share_url"];
                NSString *shareMessage = body[@"message"];
                NSString *shareWith = body[@"share_from"];
                
                
                NSString * title =[NSString stringWithFormat:shareMessage,shareUrl];
                NSArray* dataToShare = @[title];
                UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
                activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
                [self presentViewController:activityViewController animated:YES completion:^{}];
            }
            else
            {
                return;
            }
        }
    }
}

-(void) sendDataToJS
{
    Flyy *flyyInstance = [[Flyy alloc] init];
    
    NSString *jsData = [NSString stringWithFormat:@"handleSDKMessage('%@')",[flyyInstance getHeadersDataForWebViewWithSegmentId:self.segmentId]];
    [self.wkWebView evaluateJavaScript:jsData completionHandler:^(NSString *result, NSError * _Nullable error) {
        NSLog(@"%@",result);
    }];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
