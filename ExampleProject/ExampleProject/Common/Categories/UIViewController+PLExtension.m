//
//  UIViewController+PLExtension.m
//  Patrol
//
//  Created by 李林峰 on 2017/5/17.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "UIViewController+PLExtension.h"

@implementation UIViewController (PLExtension)

+ (UIViewController *)getCurrentVC{
    
    UIViewController * result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray * windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tempWindow in windows) {
            
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    
    UIView * frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController
                                      class]]) {
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

@end
