//
//  PatrolUINavigationController+StatusBar.h
//  Patrol
//
//  Created by hades on 2017/5/27.
//  Copyright © 2017年 Cloud4Magic. All rights reserved.
//

#import "PatrolUINavigationController.h"

@interface PatrolUINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle;

- (BOOL)prefersStatusBarHidden;
@end
