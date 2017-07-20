//
//  UIColor+App.h
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)

#pragma mark App Colors


+ (UIColor *)BackgroundColor;

+ (UIColor *)TextFieldTintColor;

+ (CGColorRef)TextFieldShadowColor;

+ (CGColorRef)PatrolButtonShadowColor;

+ (CGColorRef)PatrolButtonDisableShadowColor;

+ (CGColorRef)CardViewShadowColor;

+ (UIColor *)NavigationBarBackgoundColor;

+ (UIColor *)GlobalBackgroudColor;

+ (UIColor *)SideMenuViewShadowColor;

+ (UIColor *)MenuListShadowColor;

+ (UIColor *)MenuListDefaultColor;

+ (UIColor *)VideoRecordColor;

+ (UIColor *)PLPatrolPointTableNormalBackgroundColor;

+ (UIColor *)PLPatrolPointDetailTextPlaceholderColor;

+ (UIColor *)MCRadarViewColor;

+ (UIColor *)PLCalendarTodayColor;

+ (UIColor *)PLCalendarWeekdayColor;

+ (UIColor *)PLRecordsTimeLabelLightColor;

+ (UIColor *)PLRecordsTimeLabelColor;

@end
