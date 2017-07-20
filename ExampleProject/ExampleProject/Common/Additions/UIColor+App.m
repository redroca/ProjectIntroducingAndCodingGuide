//
//  UIColor+App.m
//  Patrol
//
//  Created by Benjamin on 4/6/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "UIColor+App.h"
#import "ColorMacro.h"

@implementation UIColor (App)

+ (UIColor *)NavigationBarBackgoundColor {
    return CORE_RGBCOLOR(58, 185, 255);
}

+ (UIColor *)BackgroundColor {
    return CORE_RGBCOLOR(65, 123, 333);
}


+ (UIColor *)TextFieldTintColor {
    return CORE_RGBCOLOR(0, 255, 255);
}

+ (CGColorRef)PatrolButtonShadowColor {
    return [CORE_RGBACOLOR(58, 237, 255, 0.51) CGColor];
}

+ (CGColorRef)PatrolButtonDisableShadowColor {
    return [CORE_RGBACOLOR(0, 0, 0, 0.2) CGColor];
}

+ (CGColorRef)TextFieldShadowColor {
    return [CORE_RGBACOLOR(0, 0, 0, 0.09) CGColor];
}

+ (CGColorRef)CardViewShadowColor {
    return [CORE_RGBACOLOR(200, 200, 200, 0.5) CGColor];
}


+ (UIColor *)GlobalBackgroudColor {
    return CORE_RGBCOLOR(58, 185, 255);
}

+ (UIColor *)SideMenuViewShadowColor{
    return CORE_RGBACOLOR(184, 184, 184, 0.5);
}

+ (UIColor *)MenuListShadowColor {
    return CORE_RGBCOLOR(78, 175, 223);
}

+ (UIColor *)MenuListDefaultColor {
    return CORE_RGBCOLOR(146, 146, 146);
}

+ (UIColor *)VideoRecordColor {
    return CORE_RGBCOLOR(255, 121, 137);
}

+ (UIColor *)PLPatrolPointTableNormalBackgroundColor {
    return CORE_RGBCOLOR(245, 245, 245);
}

+ (UIColor *)PLPatrolPointDetailTextPlaceholderColor {
    return CORE_RGBCOLOR(151, 151, 151);
}

+ (UIColor *)MCRadarViewColor {
    return CORE_RGBACOLOR(217, 241, 255, 1);
}

+ (UIColor *)PLCalendarTodayColor {
    return CORE_RGBCOLOR(192, 192, 192);
}

+ (UIColor *)PLCalendarWeekdayColor {
    return CORE_RGBCOLOR(174, 174, 174);
}

+ (UIColor *)PLRecordsTimeLabelLightColor {
    return CORE_RGBACOLOR(1, 1, 1, 0.6);
}

+ (UIColor *)PLRecordsTimeLabelColor {
    return CORE_RGBCOLOR(1, 1, 1);
}

@end
