//
//  WebViewController.h
//  Flyy
//
//  Created by Pooja Deshpande on 08/01/21.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController

@property (strong,nonatomic) NSString *pageLoadingTitle;
@property (strong,nonatomic) NSString *pageUrl;
@property (strong, nonatomic) NSString *segmentId;
@property (strong, nonatomic) NSString *themeColor;

@end

NS_ASSUME_NONNULL_END
