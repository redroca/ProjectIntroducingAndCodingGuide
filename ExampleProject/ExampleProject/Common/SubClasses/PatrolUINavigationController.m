//
//  PatrolUINavigationController.m
//  Patrol
//
//  Created by Benjamin on 4/7/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#import "PatrolUINavigationController.h"
#import "CommonAppHeaders.h"

@interface PatrolUINavigationController ()

@end

@implementation PatrolUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setupBarBackgroundColor:[UIColor NavigationBarBackgoundColor]];
    [self.navigationBar hideBottomHairline];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"Helvetica Neue" size:20.0]};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
