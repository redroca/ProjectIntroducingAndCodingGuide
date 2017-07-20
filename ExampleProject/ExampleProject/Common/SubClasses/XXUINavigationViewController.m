//
//  XXUINavigationViewController.m
//  ExampleProject
//
//  Created by hades on 2017/7/20.
//  Copyright © 2017年 Hades. All rights reserved.
//

#import "XXUINavigationViewController.h"
#import "CommonAppHeaders.h"

@interface XXUINavigationViewController ()

@end

@implementation XXUINavigationViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
