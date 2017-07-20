//
//  PatrolUINavigationController+StatusBar.m
//  Patrol
//
//  Created by hades on 2017/5/27.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "PatrolUINavigationController+StatusBar.h"

@implementation PatrolUINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}

- (BOOL)prefersStatusBarHidden {
    return [[self topViewController] prefersStatusBarHidden];
}
@end
